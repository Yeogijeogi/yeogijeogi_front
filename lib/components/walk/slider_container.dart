import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/utils/palette.dart';

class SliderContainer extends StatelessWidget {
  /// 상단 제목
  final String title;

  /// 척도 리스트
  final List<String> criteria;

  /// 현재 선택된 값
  final double value;

  /// 슬라이더 값 변경 함수
  final Function(double)? onChanged;

  const SliderContainer({
    super.key,
    required this.title,
    required this.criteria,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      decoration: BoxDecoration(
        color: Palette.container,
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.all(20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 제목
          Text(title, style: Palette.body),
          SizedBox(height: 20.h),

          // 슬라이더
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 8.h,
              activeTrackColor: Palette.surfaceVariant,
              inactiveTrackColor: Palette.surfaceVariant,
              disabledActiveTrackColor: Palette.surfaceVariant,
              disabledInactiveTrackColor: Palette.surfaceVariant,
              thumbColor: Palette.primary,
              disabledThumbColor: Palette.primary,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
              padding: EdgeInsets.zero,
              tickMarkShape: SliderTickMarkShape.noTickMark,
              trackShape: RectangularSliderTrackShape(),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: onChanged,
            ),
          ),
          SizedBox(height: 4.h),

          // 라벨
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(criteria.length, (index) {
              return Text(
                criteria[index],
                style: Palette.caption.copyWith(
                  color: Palette.onSurfaceVariant,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
