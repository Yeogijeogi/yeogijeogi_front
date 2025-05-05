import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:yeogijeogi/components/walk/course_detail.dart';
import 'package:yeogijeogi/models/objects/recommendation.dart';

class CourseOverview extends StatelessWidget {
  /// 추천된 경로 리스트
  final List<Recommendation> recommendations;

  final NaverMapViewOptions options;

  final Function(NaverMapController) onMapReady;

  final Function(NCameraUpdateReason, bool) onCameraChange;

  /// 페이지 컨트롤러
  final PageController controller;

  const CourseOverview({
    super.key,
    required this.recommendations,
    required this.controller,
    required this.options,
    required this.onMapReady,
    required this.onCameraChange,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller,
        itemCount: 3,
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        itemBuilder: (_, index) {
          return FractionallySizedBox(
            widthFactor: 1 / controller.viewportFraction,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                NaverMap(
                  options: options,
                  onMapReady: onMapReady,
                  onCameraChange: onCameraChange,
                ),

                // 코스 세부 정보
                CourseDetail(
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
