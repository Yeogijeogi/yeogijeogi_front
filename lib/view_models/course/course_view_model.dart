import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/models/course_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class CourseViewModel with ChangeNotifier {
  final CourseModel courseModel;
  final BuildContext context;

  CourseViewModel({required this.courseModel, required this.context}) {
    draggableController.addListener(_onDrag);
  }

  // 메모 텍스트 컨트롤러
  TextEditingController controller = TextEditingController();

  // 모달 시트 컨트롤러
  final DraggableScrollableController draggableController =
      DraggableScrollableController();

  // 모달 확장 여부 상태
  bool isExpanded = false;

  // 로딩
  bool isLoading = false;

  // 드래그 이벤트 핸들러
  void _onDrag() {
    final isNowExpanded = draggableController.size >= 0.95;

    if (isNowExpanded != isExpanded) {
      if (isNowExpanded) {
        onExpanded();
      }

      isExpanded = isNowExpanded;
      notifyListeners();
    }
  }

  /// 앱바 뒤로가기 버튼
  void onTapBack() {
    draggableController.animateTo(
      0.228,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 모달 열렸을 때 상세 정보 가져오기
  void onExpanded() async {
    if (courseModel.course!.mood == null) {
      isLoading = true;
      notifyListeners();

      final detail = await API.getCourseDetail(walkId: courseModel.course!.id);
      courseModel.course!.fromCourseDetailJson(detail);

      isLoading = false;
      notifyListeners();
    }
  }

  void onTapDelete() {
    showCustomDialog(
      type: DialogType.deleteCourse,
      context: context,
      onTapAction: context.pop,
    );
  }

  @override
  void dispose() {
    draggableController.removeListener(_onDrag);
    draggableController.dispose();
    super.dispose();
  }
}
