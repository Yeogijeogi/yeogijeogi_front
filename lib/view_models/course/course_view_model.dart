import 'package:flutter/material.dart';

class CourseViewModel with ChangeNotifier {
  BuildContext context;

  CourseViewModel({required this.context});

  /// 처음 모달 높이
  double _sheetHeight = 0.2;

  /// 모달의 현재 높이
  double get sheetHeight => _sheetHeight;

  /// 모달의 확장 상태
  bool get isExpanded => _sheetHeight > 0.5;

  /// 터치로 모달 열고 닫기
  void updateSheetHeight(double delta) {
    _sheetHeight -= delta / 400;
    _sheetHeight = _sheetHeight.clamp(0.2, 1.0);
    notifyListeners();
  }

  void toggleSheet() {
    if (_sheetHeight < 0.5) {
      _sheetHeight = 1.0;
    } else {
      _sheetHeight = 0.2;
    }
    notifyListeners();
  }
}
