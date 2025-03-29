import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/utils/palette.dart';

class CustomTextButton extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 스타일
  final TextStyle? style;

  /// 버튼 클릭시 실행 함수
  final Function()? onTap;

  const CustomTextButton({
    super.key,
    required this.text,
    this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(8.w),
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: Palette.onSurfaceVariant,
      ),
      onPressed: onTap,
      child: Text(
        text,
        style:
            style ?? Palette.caption.copyWith(color: Palette.onSurfaceVariant),
      ),
    );
  }
}
