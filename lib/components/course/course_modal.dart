import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/course/modal_course_detail.dart';
import 'package:yeogijeogi/models/objects/course.dart';
import 'package:yeogijeogi/utils/palette.dart';

class CourseModal extends StatelessWidget {
  /// 선택된 코스
  final Course? course;

  /// 모달 드래그 컨트롤러
  final DraggableScrollableController draggableScrollableController;

  /// 모달 확장 여부
  final bool isExpanded;

  /// 뒤로가기 버튼
  final void Function() onTapBack;

  /// 삭제 버튼
  final void Function() onTapDelete;

  const CourseModal({
    super.key,
    required this.draggableScrollableController,
    required this.isExpanded,
    this.course,
    required this.onTapBack,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: draggableScrollableController,
      maxChildSize: 1,
      initialChildSize: 0.228,
      minChildSize: 0.228,
      snap: true,
      snapSizes: const [0.228, 1],
      builder: (_, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Palette.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child:
              course != null
                  ? ModalCourseDetail(
                    course: course!,
                    isExpanded: isExpanded,
                    scrollController: scrollController,
                    onTapBack: onTapBack,
                    onTapDelete: onTapDelete,
                  )
                  : Column(
                    children: [
                      SizedBox(height: 78.h),
                      Text('아직 저장한 코스가 없어요.', style: Palette.headline),
                      SizedBox(height: 78.h),
                    ],
                  ),
        );
      },
    );
  }
}
