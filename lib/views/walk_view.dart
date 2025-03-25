import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_button.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/walk/slider_container.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/walk_view_model.dart';

class WalkView extends StatelessWidget {
  const WalkView({super.key});

  @override
  Widget build(BuildContext context) {
    final WalkViewModel walkViewModel = context.watch<WalkViewModel>();

    return CustomScaffold(
      isLoading: walkViewModel.isLoading,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("산책을 떠나 볼까요?", style: Palette.title),
          SizedBox(height: 8.h),
          Text("산책 코스 추천을 위해 몇가지 질문에 대답해 주세요.", style: Palette.headline),
          SizedBox(height: 40.h),
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
                Text("얼마나 걸을까요?", style: Palette.body),
                Container(
                  width: 128.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: Palette.surface,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 26.w,
                      vertical: 6.h,
                    ),
                    child: Text("1시간 30분", style: Palette.body),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          SliderContainer(
            title: "어떤 풍경을 찾아볼까요?",
            criteria: ["자연", "상관없음", "도시"],
            value: walkViewModel.sceneryLevel,
            onChanged: (value) {
              walkViewModel.updateSceneryLevel(value);
            },
          ),
          SizedBox(height: 24.h),
          SliderContainer(
            title: "산책 강도를 선택해 주세요.",
            criteria: ["가벼운", "상관없음", "운동되는"],
            value: walkViewModel.walkingLevel,
            onChanged: (value) {
              walkViewModel.updateWalkingLevel(value);
            },
          ),
          Spacer(),
          CustomButton(
            text: "코스 추천 받기",
            background: Palette.success,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
