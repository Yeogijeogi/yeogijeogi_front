import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class WalkStartViewModel with ChangeNotifier {
  WalkModel walkModel;
  BuildContext context;

  WalkStartViewModel({required this.walkModel, required this.context});

  /// 지도 페이지 controller
  final PageController controller = PageController(viewportFraction: 1.1);

  // 위치 정보
  final Location _location = Location();

  /// 로딩
  bool isLoading = false;

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
}
