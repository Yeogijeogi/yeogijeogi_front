import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart' as perm_handler;
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class OnboardingViewModel with ChangeNotifier, WidgetsBindingObserver {
  WalkModel walkModel;
  BuildContext context;

  OnboardingViewModel({required this.walkModel, required this.context}) {
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
  Duration duration = Duration(hours: 0, minutes: 30);

  /// durationPicker 선택 여부
  bool showPicker = false;

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
  void onTapCourse() {
    // WalkModel에 데이터 복사
    walkModel.sceneryLevel = sceneryLevel;
    walkModel.walkingLevel = walkingLevel;
    walkModel.duration = duration;

    // 데이터 초기화
    duration = Duration(hours: 0, minutes: 30);
    sceneryLevel = 0;
    walkingLevel = 0;
    notifyListeners();

    // 로딩 화면 이동
    context.goNamed(AppRoute.loading.name);
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
