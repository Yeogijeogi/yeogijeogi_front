import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:yeogijeogi/components/common/error_dialog.dart';
import 'package:yeogijeogi/components/walk/walk_end_dialog.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/objects/walk_summary.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/constants.dart';
import 'package:yeogijeogi/utils/custom_exception.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';
import 'package:yeogijeogi/utils/palette.dart';

class WalkViewModel with ChangeNotifier {
  WalkModel walkModel;
  BuildContext context;

  WalkViewModel({required this.walkModel, required this.context});

  /// 네이버 지도 초기화 옵션
  NaverMapViewOptions options = NaverMapViewOptions(
    initialCameraPosition: NCameraPosition(
      target: NLatLng(DEFAULT_LATITUDE, DEFAULT_LONGITUDE),
      zoom: 15,
    ),
    contentPadding: EdgeInsets.only(bottom: 90),
    logoAlign: NLogoAlign.rightBottom,
  );

  /// 네이버 지도 컨트롤러
  late NaverMapController naverMapController;

  /// 위치 버튼 활성화 여부
  bool isLocationActive = true;

  // 위치 정보
  final Location _location = Location();

  // 10초마다 실행되는 타이머
  Timer? _timer;

  // 로딩
  bool isLoading = true;

  // 타이머 실행
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 6), (_) => addCurrentLocation());
  }

  /// 지도 로딩 완료시 호출
  void onMapReady(NaverMapController controller) async {
    naverMapController = controller;

    // 현재 내 위치로 이동
    await moveToCurrentLocation();

    // 경로 그리기
    await drawPath();

    // 시작 위치 초기화
    addCurrentLocation();

    startTimer();

    isLoading = false;
    notifyListeners();
  }

  /// 경로 표시
  Future<void> drawPath() async {
    // // 경로
    await naverMapController.addOverlay(
      NPathOverlay(
        id: 'path',
        coords: walkModel.recommendation!.path,
        color: Palette.primary,
        outlineWidth: 0,
      ),
    );

    // 시작, 끝 마커
    await naverMapController.addOverlay(
      NMarker(
        id: 'start',
        position: walkModel.recommendation!.path.first,
        icon: NOverlayImage.fromAssetImage('/assets/icons/marker_start.png'),
        anchor: NPoint(0.5, 1),
      ),
    );
    await naverMapController.addOverlay(
      NMarker(
        id: 'end',
        position: walkModel.recommendation!.path.last,
        icon: NOverlayImage.fromAssetImage('/assets/icons/marker_end.png'),
        anchor: NPoint(0.5, 1),
      ),
    );
  }

  /// 내 위치로 카메라 이동 (초기화)
  Future<void> moveToCurrentLocation() async {
    await naverMapController.setLocationTrackingMode(
      NLocationTrackingMode.follow,
    );

    isLocationActive = true;
    notifyListeners();
  }

  /// 카메라 변환
  void onCameraChange(_, _) async {
    isLocationActive =
        await naverMapController.getLocationTrackingMode() ==
        NLocationTrackingMode.follow;
    notifyListeners();
  }

  /// 현재 위치 경로에 추가
  void addCurrentLocation() async {
    final Coordinate currentLocation = Coordinate.fromLocationData(
      await _location.getLocation(),
    );
    walkModel.addLocation(currentLocation);

    // 60초 경과 후 (walkPoint 6개) 서버 전송
    if (walkModel.walkPointList.length >= 6) {
      try {
        walkModel.uploadWalkPoints();
      } catch (e) {
        if (context.mounted) {
          showErrorDialog(
            exception: CustomException.fromException(e, context),
            context: context,
          );
        }
      }
    }

    // 경로 추가
    await naverMapController.addOverlay(
      NPathOverlay(
        id: 'walk_path',
        coords: walkModel.pathList,
        color: Palette.secondary,
        outlineWidth: 0,
      ),
    );
  }

  /// 산책 종료 팝업 표시
  void onTapEnd() async {
    isLoading = true;
    notifyListeners();

    _timer?.cancel();

    // 마지막 위치 업로드
    final Coordinate currentLocation = Coordinate.fromLocationData(
      await _location.getLocation(),
    );
    walkModel.addLocation(currentLocation);

    _timer = Timer.periodic(Duration(seconds: 6), (_) => addCurrentLocation());

    try {
      // 마지막 위치 포함 경로 서버 업로드
      await walkModel.uploadWalkPoints();

      // 요약 정보 가져오기
      final WalkSummary sumamry = await API.getWalkEnd(walkModel.id!);
      walkModel.summary = sumamry;

      isLoading = false;
      notifyListeners();

      if (context.mounted) {
        await showWalkEndDialog(
          context: context,
          summary: sumamry,
          onTapSave: save,
          onTapCancel: () {
            walkModel.summary = null;
            isLoading = false;
            notifyListeners();
            context.pop();
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        showErrorDialog(
          exception: CustomException.fromException(e, context),
          context: context,
        );
      }
    }

    isLoading = false;
    notifyListeners();
  }

  /// 산책 완료시 사진 촬영
  Future<void> takePicture() async {
    // 추천 경로 관련 오버레이 제거
    await naverMapController.deleteOverlay(
      NOverlayInfo(type: NOverlayType.pathOverlay, id: 'path'),
    );

    // 시작, 끝 마커 표시
    await naverMapController.addOverlay(
      NMarker(
        id: 'start',
        position: walkModel.pathList.first,
        icon: NOverlayImage.fromAssetImage('/assets/icons/marker_start.png'),
        anchor: NPoint(0.5, 1),
      ),
    );
    await naverMapController.addOverlay(
      NMarker(
        id: 'end',
        position: walkModel.pathList.last,
        icon: NOverlayImage.fromAssetImage('/assets/icons/marker_end.png'),
        anchor: NPoint(0.5, 1),
      ),
    );

    // 내 위치 마커 제거
    await naverMapController.setLocationTrackingMode(
      NLocationTrackingMode.none,
    );

    if (context.mounted) {
      final double screenWidth = MediaQuery.of(context).size.width;
      final double screenHeight = MediaQuery.of(context).size.height;

      // 정사각형이 화면의 중앙에 위치하도록 하기 위해 상하 padding 계산
      final double heightPadding = (screenHeight - screenWidth) / 2 + 40.w;

      // 지도 위치 조정
      final NLatLngBounds bounds = NLatLngBounds.from(walkModel.pathList);
      final NCameraUpdate cameraUpdate = NCameraUpdate.fitBounds(
        bounds,
        padding: EdgeInsets.symmetric(
          vertical: heightPadding,
          horizontal: 40.w,
        ),
      );

      await naverMapController.updateCamera(cameraUpdate);
    }

    // 사진 촬영
    final File image = await naverMapController.takeSnapshot(
      showControls: false,
    );
    walkModel.image = image;
  }

  /// 산책 저장
  void save() async {
    isLoading = true;
    notifyListeners();

    // 팝업 제거
    if (context.mounted) context.pop();

    // 타이머 종료
    _timer?.cancel();
    _timer = null;

    // 경로 사진 촬영
    await takePicture();

    // 이 시점에는 walkId가 null이 되면 안됨
    // 산책 종료 api 호출
    await API.postWalkEnd(
      walkModel.id!,
      walkModel.summary!,
      walkModel.recommendation!.address,
    );

    isLoading = false;
    notifyListeners();

    if (context.mounted) context.goNamed(AppRoute.save.name);
  }
}
