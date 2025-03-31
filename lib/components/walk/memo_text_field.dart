import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/utils/palette.dart';

class MemoTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  final Function(String)? onChanged;

  const MemoTextField({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Palette.container,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        style: Palette.body,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.r),
          border: InputBorder.none,
          hintText: '메모',
          hintStyle: Palette.body.copyWith(color: Palette.onSurfaceVariant),
        ),
        maxLines: 6,
        maxLength: 128,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          required maxLength,
        }) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Text(
              '$currentLength / $maxLength',
              style: Palette.caption.copyWith(color: Palette.onSurfaceVariant),
            ),
          );
        },
        onChanged: onChanged,
      ),
    );
  }
}
