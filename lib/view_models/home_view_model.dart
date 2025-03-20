import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class HomeViewModel with ChangeNotifier {
  BuildContext context;

  HomeViewModel({required this.context});

  /// 페이지 로딩 상태
  bool isLoading = false;

  /// 로그아웃 후 login 페이지로 이동
  void logout() async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) context.goNamed(AppRoute.login.name);
  }
}
