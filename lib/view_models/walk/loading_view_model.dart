import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/components/common/error_dialog.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/custom_exception.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class LoadingViewModel with ChangeNotifier {
  WalkModel walkModel;
  BuildContext context;

  LoadingViewModel({required this.walkModel, required this.context}) {
    getRecommendation();
  }

  /// 위치 정보
  final Location _location = Location();

  /// 산책 코스 추천
  void getRecommendation() async {
    // 현재 위치
    final LocationData location = await _location.getLocation();

    try {
      walkModel.recommendationList = await API.getRecommendadtion(
        coordinate: Coordinate.fromLocationData(location),
        walkTime: walkModel.duration.inMinutes,
        mood: walkModel.sceneryLevel.toInt(),
        difficulty: walkModel.walkingLevel.toInt(),
      );

      // 데이터 초기화
      walkModel.resetOnboardingData();

      // 추천 받은 경로가 없으면 팝업 표시
      if (walkModel.recommendationList.isEmpty) {
        if (context.mounted) {
          await showCustomDialog(
            type: DialogType.recommendation,
            context: context,
            onTapAction: context.pop,
            showCancel: false,
          );
        }

        if (context.mounted) context.goNamed(AppRoute.onboarding.name);
      } else {
        if (context.mounted) context.goNamed(AppRoute.walkStart.name);
      }
    } catch (e) {
      if (context.mounted) {
        showErrorDialog(
          exception: CustomException.fromException(e, context),
          context: context,
          action: () => context.goNamed(AppRoute.onboarding.name),
        );
      }
    }
  }
}
