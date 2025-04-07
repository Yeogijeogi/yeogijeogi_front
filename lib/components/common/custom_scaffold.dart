import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/loading_screen.dart';

class CustomScaffold extends StatelessWidget {
  /// 상단 제목
  final String? title;

  /// 앱바 뒤로가기 표시 여부
  final bool showBackBtn;

  /// 패딩 적용 여부
  final bool hasPadding;

  /// SafeArea 적용 여부
  final bool useSafeArea;

  /// 스와이프로 뒤로가기 가능 여부
  final bool canPop;

  /// 하단 크기 자동 조절
  final bool? resizeToAvoidBottomInset;

  /// 로딩 중 여부
  final bool isLoading;

  /// body 위젯
  final Widget? body;

  /// 화면 탭
  final Function()? onTap;

  /// 뒤로가기 버튼 함수
  final Function()? onTapBack;

  const CustomScaffold({
    super.key,
    this.title,
    this.hasPadding = true,
    this.useSafeArea = true,
    this.canPop = true,
    this.showBackBtn = false,
    this.resizeToAvoidBottomInset,
    this.isLoading = false,
    this.body,
    this.onTap,
    this.onTapBack,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        onTap?.call();
      },
      child: PopScope(
        canPop: canPop,
        child: Scaffold(
          appBar:
              title != null
                  ? AppBar(
                    title: Text(title!),
                    scrolledUnderElevation: 0,
                    leading:
                        showBackBtn
                            ? GestureDetector(
                              onTap: onTapBack ?? context.pop,
                              child: Icon(Icons.arrow_back_ios_new),
                            )
                            : null,
                  )
                  : null,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: SafeArea(
            left: useSafeArea,
            top: useSafeArea,
            right: useSafeArea,
            bottom: useSafeArea,
            child: Stack(
              children: [
                // body
                Padding(
                  padding:
                      hasPadding
                          ? EdgeInsets.symmetric(
                            vertical: 20.h,
                            horizontal: 20.w,
                          )
                          : EdgeInsets.zero,
                  child: body,
                ),

                // 로딩
                if (isLoading) const Center(child: LoadingScreen()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
