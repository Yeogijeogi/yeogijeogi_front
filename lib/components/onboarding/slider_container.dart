import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/utils/palette.dart';

class SliderContainer extends StatefulWidget {
  /// 상단 제목
  final String title;

  /// 척도 리스트
  final List<String> criterion;

  const SliderContainer({
    super.key,
    required this.title,
    required this.criterion,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      width: 353.w,
      height: 138.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 제목
          Text(
            widget.title,
            style: Palette.body.copyWith(
              color: Palette.onSurface,
              fontFamily: "Pretendard",
            ),
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
            child: SizedBox(
              width: double.infinity,
              child: Slider(
                value: _value,
                min: 0,
                max: (widget.criterion.length - 1).toDouble(),
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
          ),

          // 라벨
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.criterion.length, (index) {
              return Text(
                widget.criterion[index],
                style: Palette.caption.copyWith(
                  color: Palette.onSurfaceVariant,
                  fontFamily: "Pretendard",
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
