import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/utils/palette.dart';

class CourseDetail extends StatelessWidget {
  /// 목적지 이름
  final String name;

  /// 목적지 주소
  final String address;

  /// 거리
  final double distance;

  /// 거리 레이블
  final String distanceLabel;

  /// 거리
  final String walk;

  /// 거리 레이블
  final String walkLabel;

  /// 시간
  final int time;

  /// 시간 레이블
  final String timeLabel;

  /// Margin 표시 여부
  final bool margin;

  /// Shadow 표시 여부
  final bool shadow;

  const CourseDetail({
    super.key,
    required this.name,
    required this.address,
    required this.distance,
    required this.distanceLabel,
    required this.walk,
    required this.walkLabel,
    required this.time,
    required this.timeLabel,
    this.margin = false,
    this.shadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 113.h,
      padding: EdgeInsets.all(20.w),
      margin: margin ? EdgeInsets.all(20.w) : null,
      decoration: BoxDecoration(
        color: Palette.container,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow:
            shadow
                ? [
                  BoxShadow(
                    color: Palette.onSurfaceVariant.withValues(alpha: 0.25),
                  ),
                ]
                : null,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(name, style: Palette.headline),
              SizedBox(width: 8.w),

              Text(
                address,
                style: Palette.caption.copyWith(
                  color: Palette.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          Row(
            children: [
              // 거리
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${distance % 1 == 0 ? distance.toStringAsFixed(0) : distance.toStringAsFixed(2)}m',
                      style: Palette.callout,
                    ),
                    SizedBox(height: 8.h),

                    Text(
                      distanceLabel,
                      style: Palette.caption.copyWith(
                        color: Palette.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Divider
              Container(
                width: 1,
                height: 36.h,
                decoration: BoxDecoration(
                  color: Palette.surfaceVariant,
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),

              // 걸음
              Expanded(
                child: Column(
                  children: [
                    Text(walk, style: Palette.callout),
                    SizedBox(height: 8.h),

                    Text(
                      walkLabel,
                      style: Palette.caption.copyWith(
                        color: Palette.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Divider
              Container(
                width: 1,
                height: 36.h,
                decoration: BoxDecoration(
                  color: Palette.surfaceVariant,
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),

              // 시간
              Expanded(
                child: Column(
                  children: [
                    Text('$time분', style: Palette.callout),
                    SizedBox(height: 8.h),

                    Text(
                      timeLabel,
                      style: Palette.caption.copyWith(
                        color: Palette.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
