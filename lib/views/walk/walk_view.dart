import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/common/custom_button.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';

class WalkView extends StatelessWidget {
  const WalkView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hasPadding: false,
      useSafeArea: false,
      canPop: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NaverMap(),
          SafeArea(
            bottom: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomButton(text: '산책 종료하기', onTap: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
