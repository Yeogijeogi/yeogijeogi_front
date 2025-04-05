import 'package:flutter/material.dart';

class CourseModel with ChangeNotifier {
  /// 모달의 현재 높이
  double sheetHeight = 0.204;

  /// 모달의 확장 여부 확인
  bool isSheetExpanded() => sheetHeight > 0.5;

  /// 모달 확장/축소 토글
  void toggleSheet() {
    sheetHeight = (sheetHeight == 1.0) ? 0.204 : 1.0;
  }

  void updateSheetHeight(double newHeight) {
    sheetHeight = newHeight.clamp(0.204, 1.0);
  }

  void finalizeSheetHeight(double velocity) {
    if (velocity > 0) {
      // 아래로 드래그하면 축소
      sheetHeight = 0.204;
    } else {
      // 위로 드래그하면 확대
      sheetHeight = 1.0;
    }
  }
}
