import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class HomeViewModel with ChangeNotifier {
  BuildContext context;

  HomeViewModel({required this.context});

  /// 페이지 로딩 상태
  bool isLoading = false;

  /// 풍경 슬라이더 값
  double sceneryLevel = 0;

  /// 산책 슬라이더 값
  double walkingLevel = 0;

  /// 풍경 슬라이더 값 업데이트
  void updateSceneryLevel(double value) {
    sceneryLevel = value;
    notifyListeners();
  }

  /// 산책 슬라이더 값 업데이트
  void updateWalkingLevel(double value) {
    walkingLevel = value;
    notifyListeners();
  }

  /// 로그아웃 후 login 페이지로 이동
  void logout() async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) context.goNamed(AppRoute.login.name);
  }
}
