import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/walk/course_detail.dart';
import 'package:yeogijeogi/models/objects/recommendation.dart';

class CourseOverview extends StatelessWidget {
  /// 추천된 경로 리스트
  final List<Recommendation> recommendations;

  final NaverMapViewOptions options;

  final Function(NaverMapController) onMapReady;

  /// 페이지 컨트롤러
  final PageController controller;

  final Function(int)? onPageChanged;

  const CourseOverview({
    super.key,
    required this.recommendations,
    required this.options,
    required this.onMapReady,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 지도
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: NaverMap(options: options, onMapReady: onMapReady),
          ),

          // 코스 정보
          Container(
            margin: EdgeInsets.only(bottom: 20.h),
            height: 113.h,
            child: PageView.builder(
              controller: controller,
              itemCount: 3,
              physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast,
              ),
              onPageChanged: onPageChanged,
              itemBuilder: (_, index) {
                return FractionallySizedBox(
                  widthFactor: 1 / controller.viewportFraction,
                  child: CourseDetail(
                    name: recommendations[index].name,
                    address: recommendations[index].address,
                    distance: recommendations[index].distance,
                    distanceLabel: '거리',
                    walk: '${recommendations[index].walks}',
                    walkLabel: '걸음',
                    time: recommendations[index].time,
                    timeLabel: '시간',
                    margin: true,
                    shadow: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 뒤로가기
// https://stackoverflow.com/questions/76117215/flutter-listview-builder-horizontal-reverse-pull-to-refresh-does-not-work/76117817#76117817
