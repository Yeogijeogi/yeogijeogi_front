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
import 'package:yeogijeogi/view_models/walk/save_view_model.dart';

class SaveView extends StatelessWidget {
  const SaveView({super.key});

  @override
  Widget build(BuildContext context) {
    final SaveViewModel saveViewModel = context.watch<SaveViewModel>();

    return CustomScaffold(
      canPop: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('산책 코스는 어땠나요?', style: Palette.title),
            SizedBox(height: 8.h),

            Text('마음에 들었으면 다음을 위해 코스를 저장해 보세요.', style: Palette.headline),
            SizedBox(height: 40.h),

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
              value: saveViewModel.moodLevel,
              onChanged: saveViewModel.updateSceneryLevel,
            ),
            SizedBox(height: 24.h),

            SliderContainer(
              title: '산책 강도는 어땠나요?',
              criteria: ['쉬움', '적당함', '어려움'],
              value: saveViewModel.walkingLevel,
              onChanged: saveViewModel.updateWalkingLevel,
            ),
            SizedBox(height: 24.h),

            MemoTextField(controller: saveViewModel.controller),
            SizedBox(height: 40.h),

            Center(
              child: CustomTextButton(
                text: '저장하지 않고 종료하기',
                onTap: saveViewModel.onTapNotSave,
              ),
            ),
            SizedBox(height: 20.h),

            CustomButton(text: '산책 코스 저장하기', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
