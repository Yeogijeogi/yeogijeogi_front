import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:yeogijeogi/components/walk/walk_end_dialog.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/objects/walk_point.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/constants.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class WalkViewModel with ChangeNotifier {
  WalkModel walkModel;
  BuildContext context;

  WalkViewModel({required this.walkModel, required this.context}) {
    isLoading = true;
    notifyListeners();

    startTimer();
  }

  /// 네이버 지도 초기화 옵션
  NaverMapViewOptions options = NaverMapViewOptions(
    initialCameraPosition: NCameraPosition(
      target: NLatLng(DEFAULT_LATITUDE, DEFAULT_LONGITUDE),
      zoom: 15,
    ),
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
  bool isLoading = false;

  // 타이머 실행
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (_) => addCurrentLocation());
  }

  /// 지도 로딩 완료시 호출
  void onMapReady(NaverMapController controller) async {
    naverMapController = controller;

    // 현재 내 위치로 이동
    await moveToCurrentLocation();

    isLoading = false;
    notifyListeners();
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

    walkModel.walkPointList.add(
      WalkPoint(
        walkId: walkModel.id!,
        coordinate: currentLocation,
        createdAt: DateTime.now(),
      ),
    );
    debugPrint('WalkPoint added: $currentLocation');

    // 60초 경과 후 (walkPoint 6개) 서버 전송
    if (walkModel.walkPointList.length >= 6) {
      walkModel.uploadWalkPoints();
    }
  }

  /// 산책 종료 팝업 표시
  void onTapEnd() async {
    await showWalkEndDialog(
      context: context,
      onTapSave: save,
      onTapCancel: context.pop,
    );
  }

  /// 산책 저장
  void save() async {
    // 타이머 종료
    _timer?.cancel();
    _timer = null;

    // 마지막 위치 업로드
    final Coordinate currentLocation = Coordinate.fromLocationData(
      await _location.getLocation(),
    );
    walkModel.walkPointList.add(
      WalkPoint(
        walkId: walkModel.id!,
        coordinate: currentLocation,
        createdAt: DateTime.now(),
      ),
    );
    walkModel.uploadWalkPoints();

    // 이 시점에는 walkId가 null이 되면 안됨
    // 산책 종료 api 호출
    await API.postWalkEnd(walkModel.id!);

    if (context.mounted) context.goNamed(AppRoute.save.name);
  }
}
