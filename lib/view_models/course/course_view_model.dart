import 'package:flutter/material.dart';
import 'package:yeogijeogi/models/course_model.dart';

class CourseViewModel with ChangeNotifier {
  BuildContext context;
  CourseModel courseModel;

  CourseViewModel({required this.courseModel, required this.context});

  void toggleSheet() {
    courseModel.toggleSheet();
    notifyListeners();
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    double delta = -details.delta.dy / MediaQuery.of(context).size.height;
    courseModel.updateSheetHeight(courseModel.sheetHeight + delta);
    notifyListeners();
  }

  void onVerticalDragEnd(DragEndDetails details) {
    final double velocity = details.velocity.pixelsPerSecond.dy;
    courseModel.finalizeSheetHeight(velocity);
    notifyListeners();
  }
}
