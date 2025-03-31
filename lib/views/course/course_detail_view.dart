import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_button.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/common/custom_text_button.dart';
import 'package:yeogijeogi/components/walk/course_detail.dart';
import 'package:yeogijeogi/components/walk/slider_container.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/course/course_detail_view_model.dart';

class CourseDetailView extends StatelessWidget {
  const CourseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseDetailViewModel courseDetailViewModel =
        context.watch<CourseDetailViewModel>();

    return CustomScaffold(
      title: '산책 코스 상세 보기',
      showBackBtn: true,
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

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Palette.container,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: TextField(
                controller: courseDetailViewModel.controller,
                style: Palette.body,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.r),
                  border: InputBorder.none,
                  hintText: '메모',
                  hintStyle: Palette.body.copyWith(
                    color: Palette.onSurfaceVariant,
                  ),
                ),
                maxLines: 6,
                maxLength: 128,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                buildCounter: (
                  context, {
                  required currentLength,
                  required isFocused,
                  required maxLength,
                }) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Text(
                      '$currentLength / $maxLength',
                      style: Palette.caption.copyWith(
                        color: Palette.onSurfaceVariant,
                      ),
                    ),
                  );
                },
                onChanged: (_) {},
              ),
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
