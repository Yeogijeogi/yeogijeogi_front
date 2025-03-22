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

  /// 값 변경 콜백
  final ValueChanged<double> onChanged;

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
      height: 138.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 제목
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: Text(title, style: Palette.body),
          ),
          Spacer(),

          // 슬라이더
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 8.h,
              activeTrackColor: Palette.surfaceVariant,
              inactiveTrackColor: Palette.surfaceVariant,
              thumbColor: Palette.success,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0), // 패딩 줄이기
              child: Slider(
                value: value,
                min: 0,
                max: (criteria.length - 1).toDouble(),
                onChanged: onChanged,
              ),
            ),
          ),

          // 라벨
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(criteria.length, (index) {
                return Text(
                  criteria[index],
                  style: Palette.caption.copyWith(
                    color: Palette.onSurfaceVariant,
                    fontFamily: "Pretendard",
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
