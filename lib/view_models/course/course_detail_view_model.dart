import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/models/course_model.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class CourseDetailViewModel with ChangeNotifier {
  BuildContext context;
  CourseModel courseModel;

  CourseDetailViewModel({required this.courseModel, required this.context});

  double moodLevel = 6;
  double walkingLevel = 2;

  TextEditingController controller = TextEditingController();

  void onTapDelete() {
    showCustomDialog(
      type: DialogType.deleteCourse,
      context: context,
      onTapAction: context.pop,
    );
  }

  void toggleSheet() {
    courseModel.toggleSheet();
  }
}
