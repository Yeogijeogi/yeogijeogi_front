import 'package:flutter/material.dart';
import 'package:yeogijeogi/utils/palette.dart';

class CustomTextButton extends StatelessWidget {
  /// 버튼 텍스트
  final String text;

  /// 버튼 클릭시 실행 함수
  final Function()? onTap;

  const CustomTextButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Palette.caption.copyWith(color: Palette.onSurfaceVariant),
      ),
    );
  }
}
