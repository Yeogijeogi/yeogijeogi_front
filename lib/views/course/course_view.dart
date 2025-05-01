import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/course/course_modal.dart';
import 'package:yeogijeogi/view_models/course/course_view_model.dart';

class CourseView extends StatelessWidget {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    final courseViewModel = context.watch<CourseViewModel>();

    return CustomScaffold(
      useSafeArea: false,
      hasPadding: false,
      isLoading: courseViewModel.isLoading,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 지도
          NaverMap(
            options: courseViewModel.options,
            onMapReady: courseViewModel.onMapReady,
          ),

          // 모달
          CourseModal(
            draggableScrollableController: courseViewModel.draggableController,
            course: courseViewModel.courseModel.course,
            isExpanded: courseViewModel.isExpanded,
            textEditingController: courseViewModel.controller,
            onTapBack: courseViewModel.onTapBack,
            onTapDelete: courseViewModel.onTapDelete,
          ),
          // Text("${courseViewModel.courseModel.courses.length}"),
          // Text("${courseViewModel.courseModel.course?.id}"),
        ],
      ),
    );
  }
}
