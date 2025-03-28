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

  /// 하단 크기 자동 조절
  final bool? resizeToAvoidBottomInset;

  /// 로딩 중 여부
  final bool isLoading;

  /// body 위젯
  final Widget? body;

  /// 화면 탭
  final Function()? onTap;

  const CustomScaffold({
    super.key,
    this.title,
    this.hasPadding = true,
    this.showBackBtn = false,
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
        appBar:
            title != null
                ? AppBar(
                  title: Text(title!),
                  centerTitle: true,
                  leading:
                      showBackBtn
                          ? GestureDetector(
                            onTap: () => context.pop(),
                            child: Icon(Icons.arrow_back_ios_new),
                          )
                          : null,
                )
                : null,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(
          child: Stack(
            children: [
              // body
              Padding(
                padding:
                    hasPadding
                        ? EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0)
                        : EdgeInsets.zero,
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
