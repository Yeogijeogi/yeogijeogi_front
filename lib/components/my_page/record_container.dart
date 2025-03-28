import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/utils/palette.dart';

class RecordContainer extends StatelessWidget {
  final String title;
  final int record;
  final String unit;
  const RecordContainer({
    super.key,
    required this.title,
    required this.record,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        children: [
          Text(
            title,
            style: Palette.caption.copyWith(color: Palette.onSurfaceVariant),
          ),
          SizedBox(height: 24.h),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: record.toString(),
                  style: Palette.largeTitle.copyWith(color: Palette.primary),
                ),
                TextSpan(text: unit, style: Palette.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
