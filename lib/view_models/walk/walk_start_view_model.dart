import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class WalkStartViewModel with ChangeNotifier {
  BuildContext context;

  WalkStartViewModel({required this.context});

  // 지도 페이지 controller
  final PageController controller = PageController(viewportFraction: 1.1);

  void onTapStart() {
    context.goNamed(AppRoute.walk.name);
  }
}
