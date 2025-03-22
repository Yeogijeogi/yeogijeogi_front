import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/common/custom_app_bar.dart';
import 'package:yeogijeogi/components/common/loading_screen.dart';

class CustomScaffold extends StatelessWidget {
  final CustomAppBar? appBar;

  /// 하단 크기 자동 조절
  final bool? resizeToAvoidBottomInset;

  /// 로딩 중 여부
  final bool isLoading;

  /// body 위젯
  final Widget? body;

  /// 화면 탭
  final Function()? onTap;

  /// ### Padding, margin 등 공통 설정 값이 적용된 Scaffold
  const CustomScaffold({
    super.key,
    this.appBar,
    this.resizeToAvoidBottomInset,
    this.isLoading = false,
    this.body,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onTap?.call();
      },
      child: Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(
          child: Stack(
            children: [
              // body
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: body,
              ),

              // 로딩
              if (isLoading) const Center(child: LoadingScreen()),
            ],
          ),
        ),
      ),
    );
  }
}
