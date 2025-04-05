import 'package:flutter/material.dart';
import 'package:yeogijeogi/models/course_model.dart';

class CourseViewModel with ChangeNotifier {
  BuildContext context;
  CourseModel courseModel;

  CourseViewModel({required this.courseModel, required this.context});

  // /// 모달의 현재 높이
  // double sheetHeight = 0.2;

  // /// 모달의 확장 여부 확인
  // bool isSheetExpanded() => sheetHeight > 0.5;

  // /// 모달 확장/축소 토글
  // void toggleSheet() {
  //   sheetHeight = (sheetHeight == 1.0) ? 0.25 : 1.0;
  //   notifyListeners();
  // }

  bool isSheetExpanded() {
    return courseModel.isSheetExpanded();
  }

  void toggleSheet() {
    courseModel.toggleSheet();
  }
}
