import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/course/course_detail_view.dart';
import 'package:yeogijeogi/components/walk/course_detail.dart';
import 'package:yeogijeogi/models/objects/course.dart';
import 'package:yeogijeogi/utils/palette.dart';

class ModalCourseDetail extends StatelessWidget {
  /// 코스
  // 이 컴포넌트가 그려지는 것은 코스가 있는 상태이기 때문에 optional일 필요가 없음
  final Course course;

  /// 확장 여부
  final bool isExpanded;

  /// 모달 확장 스크롤 컨트롤러
  final ScrollController scrollController;

  /// 뒤로가기 버튼
  final void Function() onTapBack;

  /// 삭제 버튼
  final void Function() onTapDelete;

  const ModalCourseDetail({
    super.key,
    required this.isExpanded,
    required this.scrollController,
    required this.course,
    required this.onTapBack,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      padding: EdgeInsets.zero,
      controller: scrollController,
      children: [
        // 핸들
        if (!isExpanded)
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 16.h, bottom: 20.h),
              decoration: BoxDecoration(
                color: Palette.onSurfaceVariant,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),

        Padding(
          padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
          child:
              isExpanded
                  ? CourseDetailView(
                    course: course,
                    onTapBack: onTapBack,
                    onTapDelete: onTapDelete,
                  )
                  : Align(
                    alignment: Alignment.topCenter,
                    child: CourseDetail(
                      name: course.name,
                      address: course.address,
                      distance: course.distance,
                      distanceLabel: '이동 거리',
                      walk: '${course.speed}km/h',
                      walkLabel: '평균 속도',
                      time: course.time,
                      timeLabel: '소요 시간',
                    ),
                  ),
        ),
      ],
    );
  }
}
