import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppBarLeadingType {
  logo(icon: 'assets/icons/appicon.svg', size: 44),
  back(icon: 'assets/icons/chevron_left.svg', size: 32);

  final String icon;
  final double size;

  const AppBarLeadingType({required this.icon, required this.size});

  Function()? onTap(BuildContext context) {
    if (this == AppBarLeadingType.back) {
      context.pop();
    }

    return null;
  }
}
