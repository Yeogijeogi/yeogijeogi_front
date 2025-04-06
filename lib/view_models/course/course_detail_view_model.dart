import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/models/course_model.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class CourseDetailViewModel with ChangeNotifier {
  CourseModel courseModel;
  BuildContext context;
  DraggableScrollableController draggableController;

  CourseDetailViewModel({
    required this.courseModel,
    required this.context,
    required this.draggableController,
  });

  double moodLevel = 6;
  double walkingLevel = 2;

  TextEditingController controller = TextEditingController();

  /// 앱바 뒤로가기 버튼
  void onTapBack() {
    draggableController.animateTo(
      0.204,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onTapDelete() {
    showCustomDialog(
      type: DialogType.deleteCourse,
      context: context,
      onTapAction: context.pop,
    );
  }
}
