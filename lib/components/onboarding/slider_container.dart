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
  final Function(double) onChanged;

  const SliderContainer({
    super.key,
    required this.title,
    required this.criteria,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.container,
        borderRadius: BorderRadius.circular(20.r),
      ),
      width: double.infinity,
      height: 133.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
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
                thumbColor: Palette.primary,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
                padding: EdgeInsets.zero,
              ),
              child: Slider(
                value: value,
                min: 0,
                max: (criteria.length - 1).toDouble(),
                onChanged: onChanged,
              ),
            ),
            SizedBox(height: 8.h),
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
      ),
    );
  }
}
