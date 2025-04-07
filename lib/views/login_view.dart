import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/login/login_button.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginViewModel loginViewModel = context.watch<LoginViewModel>();

    return CustomScaffold(
      isLoading: loginViewModel.isLoading,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 로고
          Expanded(child: SvgPicture.asset('assets/icons/appicon.svg')),

          // 구글 로그인
          LoginButton(
            icon: 'logo_google.svg',
            text: 'Google로 시작하기',
            background: Palette.container,
            onTap: loginViewModel.signInWithGoogle,
          ),
          if (Platform.isIOS) SizedBox(height: 12.h),

          // 애플 로그인
          if (Platform.isIOS)
            LoginButton(
              icon: 'logo_apple.svg',
              text: 'Apple로 시작하기',
              background: Palette.container,
              onTap: loginViewModel.signInWithApple,
            ),

          SizedBox(height: 64.h),
        ],
      ),
    );
  }
}
