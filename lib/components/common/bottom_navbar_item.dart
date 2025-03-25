import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

BottomNavigationBarItem bottomNavbarItem({
  required String src,
  required String active,
  required String label,
}) {
  return BottomNavigationBarItem(
    icon: Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: SvgPicture.asset(src, width: 24.w, height: 24.h),
    ),
    activeIcon: Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: SvgPicture.asset(active, width: 24.w, height: 24.h),
    ),
    label: label,
  );
}
