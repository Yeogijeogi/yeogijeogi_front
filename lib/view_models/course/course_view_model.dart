import 'package:flutter/material.dart';
import 'package:yeogijeogi/models/course_model.dart';

class CourseViewModel with ChangeNotifier {
  final BuildContext context;
  final CourseModel courseModel;

  // 모달 시트 컨트롤러
  final DraggableScrollableController draggableController =
      DraggableScrollableController();

  // 모달 확장 여부 상태
  bool isExpanded = false;

  CourseViewModel({required this.courseModel, required this.context}) {
    draggableController.addListener(_onDrag);
  }

  // 드래그 이벤트 핸들러
  void _onDrag() {
    final isNowExpanded = draggableController.size >= 0.95;
    if (isNowExpanded != isExpanded) {
      isExpanded = isNowExpanded;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    draggableController.removeListener(_onDrag);
    draggableController.dispose();
    super.dispose();
  }
}
