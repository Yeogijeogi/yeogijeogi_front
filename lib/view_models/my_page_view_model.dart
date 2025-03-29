import 'package:flutter/material.dart';

class MyPageViewModel with ChangeNotifier {
  BuildContext context;

  MyPageViewModel({required this.context});

  /// 페이지 로딩 상태
  bool isLoading = false;
}
