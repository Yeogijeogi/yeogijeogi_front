import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class MyPageViewModel with ChangeNotifier {
  BuildContext context;

  MyPageViewModel({required this.context});

  /// 페이지 로딩 상태
  bool isLoading = false;

  /// 회원탈퇴
  void onTapDeleteAccount() {
    showCustomDialog(
      type: DialogType.deleteAccount,
      context: context,
      onTapAction: context.pop,
    );
  }

  /// 로그아웃
  void onTapLogout() {
    showCustomDialog(
      type: DialogType.logout,
      context: context,
      onTapAction: () async {
        /// 로그아웃 후 login 페이지로 이동
        await FirebaseAuth.instance.signOut();
        if (context.mounted) context.goNamed(AppRoute.login.name);
      },
    );
  }
}
