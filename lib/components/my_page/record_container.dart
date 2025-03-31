import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/utils/palette.dart';

class RecordContainer extends StatelessWidget {
  const RecordContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Palette.container,
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  '지금까지 산책한 거리',
                  style: Palette.caption.copyWith(
                    color: Palette.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 24.h),

                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '24',
                        style: Palette.largeTitle.copyWith(
                          color: Palette.primary,
                        ),
                      ),
                      TextSpan(text: 'km', style: Palette.body),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 20.w),
          Container(
            width: 1,
            height: 70.h,
            decoration: BoxDecoration(
              color: Palette.surfaceVariant,
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
          SizedBox(width: 20.w),

          Expanded(
            child: Column(
              children: [
                Text(
                  '지금까지 산책한 시간',
                  style: Palette.caption.copyWith(
                    color: Palette.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: 24.h),

                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '452',
                        style: Palette.largeTitle.copyWith(
                          color: Palette.primary,
                        ),
                      ),
                      TextSpan(text: '분', style: Palette.body),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
