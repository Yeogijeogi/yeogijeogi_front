import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_button.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/walk/slider_container.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/walk/onboarding_view_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingViewModel onboardingViewModel =
        context.watch<OnboardingViewModel>();

    return CustomScaffold(
      isLoading: onboardingViewModel.isLoading,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('산책을 떠나 볼까요?', style: Palette.title),
          SizedBox(height: 8.h),

          Text('산책 코스 추천을 위해 몇가지 질문에 대답해 주세요.', style: Palette.headline),
          SizedBox(height: 40.h),

          // 시간
          Container(
            width: double.infinity,
            height: 64.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Palette.container,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('얼마나 걸을까요?', style: Palette.body),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        int selectedHour = onboardingViewModel.duration.inHours;
                        int selectedMinute =
                            onboardingViewModel.duration.inMinutes % 60;

                        return SizedBox(
                          height: 250,
                          child: Row(
                            children: [
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                    initialItem: selectedHour,
                                  ),
                                  itemExtent: 32,
                                  onSelectedItemChanged: (index) {
                                    selectedHour = index;
                                    onboardingViewModel.selectDurationTime(
                                      Duration(
                                        hours: selectedHour,
                                        minutes: selectedMinute,
                                      ),
                                    );
                                  },
                                  children: List.generate(
                                    24,
                                    (i) => Center(child: Text('$i 시간')),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CupertinoPicker(
                                  scrollController: FixedExtentScrollController(
                                    initialItem: selectedMinute,
                                  ),
                                  itemExtent: 32,
                                  onSelectedItemChanged: (index) {
                                    selectedMinute = index;
                                    onboardingViewModel.selectDurationTime(
                                      Duration(
                                        hours: selectedHour,
                                        minutes: selectedMinute,
                                      ),
                                    );
                                  },
                                  children: List.generate(
                                    60,
                                    (i) => Center(child: Text('$i 분')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 128.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: Palette.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "${onboardingViewModel.duration.inHours}시간 ${onboardingViewModel.duration.inMinutes.remainder(60)}분",
                        style: Palette.body,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // 분위기
          SliderContainer(
            title: '어떤 분위기를 원하시나요?',
            criteria: ['자연', '상관없음', '도시'],
            value: onboardingViewModel.sceneryLevel,
            onChanged: (value) {
              onboardingViewModel.updateSceneryLevel(value);
            },
          ),
          SizedBox(height: 24.h),

          // 강도
          SliderContainer(
            title: '산책 강도를 선택해 주세요.',
            criteria: ['가벼운', '상관없음', '운동되는'],
            value: onboardingViewModel.walkingLevel,
            onChanged: (value) {
              onboardingViewModel.updateWalkingLevel(value);
            },
          ),
          Spacer(),
          CustomButton(
            text: '코스 추천 받기',
            onTap: onboardingViewModel.onTapCourse,
          ),
        ],
      ),
    );
  }
}
