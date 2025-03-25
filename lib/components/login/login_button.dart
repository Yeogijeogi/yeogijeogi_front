import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yeogijeogi/components/common/custom_ink_well.dart';
import 'package:yeogijeogi/utils/palette.dart';

class LoginButton extends StatelessWidget {
  final String icon;
  final String text;
  final Color background;
  final Function()? onTap;

  const LoginButton({
    super.key,
    required this.icon,
    required this.text,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      backgroundColor: background,
      child: Container(
        width: double.infinity,
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/icons/$icon', width: 20.w, height: 20.w),
            Text(text, style: Palette.callout),
            SizedBox(width: 20.w),
          ],
        ),
      ),
    );
  }
}
