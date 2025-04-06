import 'package:flutter/material.dart';
import 'package:yeogijeogi/utils/palette.dart';

class CustomModalAppBar extends StatelessWidget {
  final String title;
  final Function() onTapBack;

  const CustomModalAppBar({
    super.key,
    required this.title,
    required this.onTapBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: kToolbarHeight,
        width: double.infinity,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 왼쪽 뒤로가기 버튼
              GestureDetector(
                onTap: onTapBack,
                behavior: HitTestBehavior.translucent,
                child: const Icon(Icons.arrow_back_ios_new),
              ),

              // 타이틀
              Text(title, style: Palette.headline),

              const SizedBox(width: 24),
            ],
          ),
        ),
      ),
    );
  }
}
