import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/common/custom_ink_well.dart';
import 'package:yeogijeogi/utils/palette.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color background;
  final Function()? onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      backgroundColor: background,
      child: Container(
        width: double.infinity,
        height: 56.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Palette.headline.copyWith(color: Palette.surface),
            ),
          ],
        ),
      ),
    );
  }
}
