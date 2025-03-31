import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/common/custom_ink_well.dart';
import 'package:yeogijeogi/utils/palette.dart';

class InkWellTile extends StatelessWidget {
  final String title;
  final String? action;
  final Function()? onTap;
  const InkWellTile({super.key, required this.title, this.action, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Palette.body),

            action != null
                ? Text(
                  action!,
                  style: Palette.body.copyWith(color: Palette.onSurfaceVariant),
                )
                : Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.w,
                  color: Palette.onSurfaceVariant,
                ),
          ],
        ),
      ),
    );
  }
}
