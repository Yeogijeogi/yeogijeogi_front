import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/walk/course_overview.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/walk/walk_start_view_model.dart';

class WalkStartView extends StatelessWidget {
  const WalkStartView({super.key});

  @override
  Widget build(BuildContext context) {
    final WalkStartViewModel walkStartViewModel =
        context.watch<WalkStartViewModel>();

    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이런 코스를 추천해요!', style: Palette.title),
          SizedBox(height: 40.h),

          // 지도
          CourseOverview(controller: walkStartViewModel.controller),
          SizedBox(height: 8.h),

          // 지도 Page indicator
          Center(
            child: SmoothPageIndicator(
              controller: walkStartViewModel.controller,
              count: 3,
              effect: SlideEffect(
                dotWidth: 8.w,
                dotHeight: 8.w,
                radius: 4.w,
                spacing: 4.w,
                dotColor: Palette.onSurfaceVariant,
                activeDotColor: Palette.primary,
              ),
            ),
          ),
          SizedBox(height: 20.h),

          SizedBox(width: double.infinity, height: 76.h),
        ],
      ),
    );
  }
}
