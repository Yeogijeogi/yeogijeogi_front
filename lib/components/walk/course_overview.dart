import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/walk/course_detail.dart';
import 'package:yeogijeogi/utils/palette.dart';

class CourseOverview extends StatelessWidget {
  final PageController controller;

  const CourseOverview({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: 3,
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        itemBuilder: (_, pageIndex) {
          return FractionallySizedBox(
            widthFactor: 1 / controller.viewportFraction,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // 지도
                Container(
                  decoration: BoxDecoration(
                    color: Palette.primary,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),

                // 코스 세부 정보
                CourseDetail(
                  name: '성북천',
                  address: '서울 성북구 동선동2가',
                  distance: 1.3,
                  distanceLabel: '거리',
                  walk: '2000',
                  walkLabel: '걸음',
                  time: 20,
                  timeLabel: '시간',
                  margin: true,
                  shadow: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 뒤로가기
// https://stackoverflow.com/questions/76117215/flutter-listview-builder-horizontal-reverse-pull-to-refresh-does-not-work/76117817#76117817
