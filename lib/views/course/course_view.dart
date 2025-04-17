import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/walk/course_detail.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/course/course_view_model.dart';
import 'package:yeogijeogi/components/course/course_detail_view.dart';

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
          const NaverMap(),

          // 모달
          DraggableScrollableSheet(
            controller: courseViewModel.draggableController,
            maxChildSize: 1.0,
            initialChildSize: 0.228,
            minChildSize: 0.228,
            snap: true,
            snapSizes: const [0.228, 1.0],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Palette.surface,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  children: [
                    // 핸들
                    if (!courseViewModel.isExpanded)
                      Container(
                        width: 40.w,
                        height: 4.h,
                        margin: EdgeInsets.only(top: 16.h, bottom: 20.h),
                        decoration: BoxDecoration(
                          color: Palette.onSurfaceVariant,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),

                    // 내용 영역
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        physics:
                            courseViewModel.isExpanded
                                ? null
                                : ClampingScrollPhysics(),
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 20.h,
                              left: 20.w,
                              right: 20.w,
                            ),
                            child:
                                courseViewModel.isExpanded
                                    ? CourseDetailView(
                                      course:
                                          courseViewModel.courseModel.course!,
                                      controller: courseViewModel.controller,
                                      onTapBack: courseViewModel.onTapBack,
                                      onTapDelete: courseViewModel.onTapDelete,
                                    )
                                    : Align(
                                      alignment: Alignment.topCenter,
                                      child: CourseDetail(
                                        name:
                                            courseViewModel
                                                .courseModel
                                                .course!
                                                .name,
                                        address:
                                            courseViewModel
                                                .courseModel
                                                .course!
                                                .address,
                                        distance:
                                            courseViewModel
                                                .courseModel
                                                .course!
                                                .distance,
                                        distanceLabel: '이동 거리',
                                        walk:
                                            '${courseViewModel.courseModel.course!.speed}km/h',
                                        walkLabel: '평균 속도',
                                        time:
                                            courseViewModel
                                                .courseModel
                                                .course!
                                                .time,
                                        timeLabel: '소요 시간',
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
