import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class SaveViewModel with ChangeNotifier {
  BuildContext context;

  SaveViewModel({required this.context});

  /// 분위기 슬라이더 값
  double moodLevel = 0;

  /// 산책 슬라이더 값
  double walkingLevel = 0;

  /// 메모 Text Controller
  TextEditingController controller = TextEditingController();

  /// 분위기 슬라이더 값 업데이트
  void updateSceneryLevel(double value) {
    moodLevel = value;
    notifyListeners();
  }

  /// 산책 슬라이더 값 업데이트
  void updateWalkingLevel(double value) {
    walkingLevel = value;
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

  /// 저장하지 않고 종료
  void onTapNotSave() {
    showCustomDialog(
      type: DialogType.notSave,
      context: context,
      onTapAction: context.pop,
    );
  }
}
