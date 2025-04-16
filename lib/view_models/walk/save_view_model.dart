import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class SaveViewModel with ChangeNotifier {
  WalkModel walkModel;
  BuildContext context;

  SaveViewModel({required this.walkModel, required this.context});

  /// 분위기 슬라이더 값
  double moodLevel = 5;

  /// 산책 슬라이더 값
  double difficultyLevel = 5;

  /// 메모 Text Controller
  TextEditingController controller = TextEditingController();

  /// 분위기 슬라이더 값 업데이트
  void updateSceneryLevel(double value) {
    moodLevel = value;
    notifyListeners();
  }

  /// 산책 슬라이더 값 업데이트
  void updateWalkingLevel(double value) {
    difficultyLevel = value;
    notifyListeners();
  }

  /// 메모 입력 6줄 제한
  TextEditingValue limitLines(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    int newLines = newValue.text.split('\n').length;
    if (newLines > 6) {
      return oldValue;
    } else {
      return newValue;
    }
  }

  /// 저장
  void onTapSave() async {
    await API.patchWalkEnd(
      walkModel.id!,
      moodLevel.toInt(),
      difficultyLevel.toInt(),
      controller.text.trim(),
    );

    walkModel.reset();

    if (context.mounted) context.goNamed(AppRoute.course.name);
  }
}
