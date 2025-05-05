import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/constants.dart';
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

  /// 로딩
  bool isLoading = false;

  /// 위치 버튼 활성화 여부
  bool isLocationActive = true;

  /// 산책 시작 버튼
  void onTapStart() async {
    isLoading = true;
    notifyListeners();

    // 현재 위치
    final LocationData location = await _location.getLocation();

    // 산책 코스 선택
    walkModel.selectRecommendation(
      controller.page!.toInt(),
      Coordinate.fromLocationData(location),
    );

    isLoading = false;
    notifyListeners();

    if (context.mounted) context.goNamed(AppRoute.walk.name);
  }

  /// 네이버 지도 초기화 옵션
  NaverMapViewOptions options = NaverMapViewOptions(
    initialCameraPosition: NCameraPosition(
      target: NLatLng(DEFAULT_LATITUDE, DEFAULT_LONGITUDE),
      zoom: 15,
    ),
  );

  /// 위치 경로에 추가
  void addLocation() async {
    walkModel.addRecommendationLocation(
      walkModel.recommendationList[controller.page!.toInt()].routes!,
    );

    // 경로 추가
    await naverMapController.addOverlay(
      NPathOverlay(
        id: 'walk_path',
        coords: walkModel.recommendationPathList,
        color: Palette.secondary,
        outlineWidth: 0,
      ),
    );
  }

  /// 지도 로딩 완료시 호출
  void onMapReady(NaverMapController controller) async {
    naverMapController = controller;

    // 현재 내 위치로 이동
    await moveToCurrentLocation();

    addLocation();

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
}
