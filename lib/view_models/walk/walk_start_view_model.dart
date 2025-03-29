import 'package:flutter/material.dart';

class WalkStartViewModel with ChangeNotifier {
  BuildContext context;

  WalkStartViewModel({required this.context});

  // 지도 페이지 controller
  final PageController controller = PageController(viewportFraction: 1.1);
}
