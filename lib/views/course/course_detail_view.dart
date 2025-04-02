import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_button.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/common/custom_text_button.dart';
import 'package:yeogijeogi/components/walk/course_detail.dart';
import 'package:yeogijeogi/components/walk/memo_text_field.dart';
import 'package:yeogijeogi/components/walk/slider_container.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/course/course_detail_view_model.dart';
import 'package:yeogijeogi/view_models/course/course_view_model.dart';

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseDetailViewModel courseDetailViewModel =
        context.watch<CourseDetailViewModel>();

    return CustomScaffold(
      title: '산책 코스 상세 보기',
      onTapBack: () {
        final courseViewModel = context.read<CourseViewModel>();
        courseViewModel.toggleSheet();
      },
      showBackBtn: true,
      hasPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 지도 이미지
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
            SizedBox(height: 24.h),

            CourseDetail(
              name: '성북천',
              address: '서울 성북구 동선동2가',
              distance: 1.3,
              distanceLabel: '이동 거리',
              walk: '3km/h',
              walkLabel: '평균 속도',
              time: 24,
              timeLabel: '소요 시간',
            ),
            SizedBox(height: 24.h),

            SliderContainer(
              title: '분위기가 어땠나요?',
              criteria: ['자연', '도시'],
              value: courseDetailViewModel.moodLevel,
            ),
            SizedBox(height: 24.h),

            SliderContainer(
              title: '산책 강도는 어땠나요?',
              criteria: ['쉬움', '적당함', '어려움'],
              value: courseDetailViewModel.walkingLevel,
            ),
            SizedBox(height: 24.h),

            MemoTextField(
              controller: courseDetailViewModel.controller,
              readOnly: true,
            ),
            SizedBox(height: 40.h),

            Center(
              child: CustomTextButton(
                text: '코스 삭제하기',
                style: Palette.caption.copyWith(color: Palette.error),
                onTap: courseDetailViewModel.onTapDelete,
              ),
            ),
            SizedBox(height: 20.h),

            CustomButton(text: '이 코스로 산책하기', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
