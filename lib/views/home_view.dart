import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_button.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/onboarding/slider_container.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = context.watch<HomeViewModel>();

    return CustomScaffold(
      isLoading: homeViewModel.isLoading,
      body:
      // Center(
      //   child: FilledButton(
      //     onPressed: homeViewModel.logout,
      //     child: Text('로그아웃'),
      //   ),
      // ),
      Padding(
        padding: EdgeInsets.only(top: 59.h, left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "산책을 떠나 볼까요?",
              style: Palette.title.copyWith(
                color: Palette.onSurface,
                fontFamily: "Pretendard",
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "코스 추천을 위해 몇가지 질문에 대답해 주세요.",
              style: Palette.headline.copyWith(
                color: Palette.onSurface,
                fontFamily: "Pretendard",
              ),
            ),
            SizedBox(height: 40.h),
            Container(
              width: 353.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "얼마나 걸을까요?",
                      style: Palette.body.copyWith(
                        color: Palette.onSurface,
                        fontFamily: "Pretendard",
                      ),
                    ),
                    Container(
                      width: 128.w,
                      height: 36.h,
                      decoration: BoxDecoration(color: Color(0xFFF8F9FA)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 26.w,
                          vertical: 6.h,
                        ),
                        child: Text(
                          "1시간 30분",
                          style: Palette.body.copyWith(
                            color: Palette.onSurface,
                            fontFamily: "Pretendard",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            SliderContainer(
              title: "어떤 풍경을 찾아볼까요?",
              criterion: ["자연", "상관없음", "도시"],
            ),
            SizedBox(height: 24.h),
            SliderContainer(
              title: "산책 강도를 선택해 주세요.",
              criterion: ["가벼운", "상관없음", "운동되는"],
            ),
            Spacer(),
            CustomButton(
              text: "코스 추천 받기",
              background: Color(0xFF198754),
              onTap: () {},
            ),
            SizedBox(height: 34.h),
          ],
        ),
      ),
    );
  }
}
