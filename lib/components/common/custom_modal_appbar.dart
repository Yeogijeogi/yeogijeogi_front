import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      decoration: const BoxDecoration(
        color: Colors.transparent, // 모달에서는 배경 투명
      ),
      child: Row(
        children: [
          if (showBackBtn)
            GestureDetector(
              onTap: onTapBack ?? () => Navigator.of(context).pop(),
              behavior: HitTestBehavior.translucent,
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          if (showBackBtn) SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
