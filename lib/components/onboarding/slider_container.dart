import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/utils/palette.dart';

class SliderContainer extends StatefulWidget {
  /// 상단 제목
  final String title;

  /// 척도 리스트
  final List<String> criteria;

  const SliderContainer({
    super.key,
    required this.title,
    required this.criteria,
  });

  @override
  State<SliderContainer> createState() => _SliderContainerState();
}

class _SliderContainerState extends State<SliderContainer> {
  double _value = 0; // 슬라이더 값 (초기값)

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
            child: Text(widget.title, style: Palette.body),
          ),
          Spacer(),

          // 슬라이더
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 8.h,
              activeTrackColor: Palette.track,
              inactiveTrackColor: Palette.track,
              thumbColor: Palette.success,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0), // 패딩 줄이기
              child: Slider(
                value: _value,
                min: 0,
                max: (widget.criteria.length - 1).toDouble(),
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
          ),

          // 라벨
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.criteria.length, (index) {
                return Text(
                  widget.criteria[index],
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
