import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as perm_handler;
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class OnboardingViewModel with ChangeNotifier, WidgetsBindingObserver {
  BuildContext context;
  WalkModel walkModel;

  OnboardingViewModel({required this.context, required this.walkModel}) {
    WidgetsBinding.instance.addObserver(this);
    checkPermission();
  }

  /// 페이지 로딩 상태
  bool isLoading = false;

  /// 풍경 슬라이더 값
  double sceneryLevel = 0;

  /// 산책 슬라이더 값
  double walkingLevel = 0;

  /// 산책 시간
  Duration duration = Duration(hours: 0, minutes: 0);

  /// durationPicker 선택 여부
  bool showPicker = false;

  /// 위치 정보
  final Location _location = Location();

  /// durationPicker 클릭시 모달
  void togglePicker() {
    showPicker = !showPicker;
    notifyListeners();
  }

  /// 시간 선택 duration 변경
  void selectDurationTime(Duration value) {
    duration = value;
    notifyListeners();
  }

  /// 설정 이동 후 복귀시 권한 확인
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final status = await perm_handler.Permission.location.status;
      if (status.isGranted && context.mounted) {
        context.pop();
      }
    }
  }

  /// 권한 확인
  void checkPermission() async {
    final perm_handler.PermissionStatus status =
        await perm_handler.Permission.location.request();

    if ((status.isDenied || status.isPermanentlyDenied) && context.mounted) {
      await showCustomDialog(
        type: DialogType.location,
        context: context,
        showCancel: false,
        onTapAction: perm_handler.openAppSettings,
      );
    }
  }

  /// 코스 추천 버튼 클릭
  void onTapCourse() async {
    // 현재 위치
    final LocationData location = await _location.getLocation();

    isLoading = true;
    notifyListeners();

    walkModel.recommendationList = await API.getRecommendadtion(
      coordinate: Coordinate.fromLocationData(location),
      walkTime: duration.inMinutes,
      mood: sceneryLevel.toInt(),
      difficulty: walkingLevel.toInt(),
    );

    isLoading = false;
    notifyListeners();

    context.goNamed(AppRoute.walkStart.name);
  }

  /// 풍경 슬라이더 값 업데이트
  void updateSceneryLevel(double value) {
    sceneryLevel = value;
    notifyListeners();
  }

  /// 산책 슬라이더 값 업데이트
  void updateWalkingLevel(double value) {
    walkingLevel = value;
    notifyListeners();
  }
}
