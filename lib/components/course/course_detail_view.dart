import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/common/custom_modal_appbar.dart';
import 'package:yeogijeogi/components/common/custom_text_button.dart';
import 'package:yeogijeogi/components/walk/course_detail.dart';
import 'package:yeogijeogi/components/walk/memo_text_field.dart';
import 'package:yeogijeogi/components/walk/slider_container.dart';
import 'package:yeogijeogi/models/objects/course.dart';
import 'package:yeogijeogi/utils/palette.dart';

class CourseDetailView extends StatelessWidget {
  final Course course;
  final TextEditingController controller;
  final Function() onTapBack;
  final Function() onTapDelete;
  const CourseDetailView({
    super.key,
    required this.course,
    required this.controller,
    required this.onTapBack,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 앱바
        CustomModalAppBar(title: '산책 코스 상세 보기', onTapBack: onTapBack),
        SizedBox(height: 20.h),

        Container(
          color: Palette.primary,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
        ),
        SizedBox(height: 24.h),

        CourseDetail(
          name: course.name,
          address: course.address,
          distance: course.distance,
          distanceLabel: '이동 거리',
          walk: course.speed!.toString(),
          walkLabel: '평균 속도',
          time: course.time,
          timeLabel: '소요 시간',
        ),
        SizedBox(height: 24.h),

        SliderContainer(
          title: '분위기가 어땠나요?',
          criteria: ['자연', '도시'],
          value: course.mood ?? 5,
        ),
        SizedBox(height: 24.h),

        SliderContainer(
          title: '산책 강도는 어땠나요?',
          criteria: ['쉬움', '적당함', '어려움'],
          value: course.difficulty ?? 5,
        ),
        SizedBox(height: 24.h),

        MemoTextField(controller: controller, readOnly: true),
        SizedBox(height: 40.h),

        Center(
          child: CustomTextButton(
            text: '코스 삭제하기',
            style: Palette.caption.copyWith(color: Palette.error),
            onTap: onTapDelete,
          ),
        ),
      ],
    );
  }
}
