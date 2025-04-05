import 'package:flutter/material.dart';

class CourseViewModel with ChangeNotifier {
  BuildContext context;

  CourseViewModel({required this.context});

  /// 모달의 현재 높이
  double sheetHeight = 0.2;

  /// 모달의 확장 여부 확인
  bool isSheetExpanded() => sheetHeight > 0.5;

  /// 모달 확장/축소 토글
  void toggleSheet() {
    sheetHeight = (sheetHeight == 1.0) ? 0.25 : 1.0;
    notifyListeners();
  }
}
