import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/utils/palette.dart';

class CustomModalAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onTapBack;
  final bool showBackBtn;

  const CustomModalAppBar({
    super.key,
    required this.title,
    this.onTapBack,
    this.showBackBtn = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 가운데 타이틀
          Center(child: Text(title, style: Palette.headline)),

          // 왼쪽 뒤로가기 버튼
          if (showBackBtn)
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: onTapBack ?? () => Navigator.of(context).pop(),
                behavior: HitTestBehavior.translucent,
                child: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
        ],
      ),
    );
  }
}
