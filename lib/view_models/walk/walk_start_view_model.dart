import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:yeogijeogi/utils/palette.dart';

class WalkStartViewModel with ChangeNotifier {
  WalkModel walkModel;
  BuildContext context;
  WalkStartViewModel({required this.walkModel, required this.context});

  /// 지도 페이지 controller
  final PageController controller = PageController(viewportFraction: 1.1);

  // 위치 정보
  final Location _location = Location();

  /// 네이버 지도 컨트롤러
  late NaverMapController naverMapController;

  /// 네이버 지도 초기화 옵션
  final NaverMapViewOptions options = NaverMapViewOptions(
    zoomGesturesEnable: false,
    scrollGesturesEnable: false,
    tiltGesturesEnable: false,
    rotationGesturesEnable: false,
    stopGesturesEnable: false,
    contentPadding: EdgeInsets.only(bottom: 133),
  );

  /// 로딩
  bool isLoading = true;

  /// 위치 버튼 활성화 여부
  bool isLocationActive = true;

  /// 지도 로딩 완료시 호출
  void onMapReady(NaverMapController controller) async {
    naverMapController = controller;
    naverMapController.setLocationTrackingMode(NLocationTrackingMode.none);

    // 지도 로딩 완료되면 첫 번째 추천 코스 그리기
    drawPath(0);

    isLoading = false;
    notifyListeners();
  }

  /// 코스 경로 그리기
  void drawPath(int index) async {
    final path = walkModel.recommendationList[index].path;

    // 오버레이 추가
    await naverMapController.addOverlay(
      NPathOverlay(
        id: 'walk_path',
        coords: path,
        color: Palette.primary,
        outlineWidth: 0,
      ),
    );

    // 경로 bounds
    final NLatLngBounds bounds = NLatLngBounds.from(path);

    // 카메라를 bounds에 맞게 이동
    final cameraUpdate = NCameraUpdate.fitBounds(
      bounds,
      padding: EdgeInsets.all(40.w),
    );
    await naverMapController.updateCamera(cameraUpdate);
  }

  void onPageChanged(int index) {
    drawPath(index);
  }

  /// 산책 시작 버튼
  void onTapStart() async {
    isLoading = true;
    notifyListeners();

    // 현재 위치
    final LocationData location = await _location.getLocation();

    // 산책 코스 선택
    await walkModel.selectRecommendation(
      controller.page!.toInt(),
      Coordinate.fromLocationData(location),
    );

    isLoading = false;
    notifyListeners();

    if (context.mounted) context.goNamed(AppRoute.walk.name);
  }
}
