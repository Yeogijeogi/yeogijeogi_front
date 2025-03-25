import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/bottom_navbar_item.dart';

class BottomNavbar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavbar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              bottomNavbarItem(
                src: 'assets/icons/navbar_course.svg',
                active: 'assets/icons/navbar_course_selected.svg',
                label: '코스',
              ),
              bottomNavbarItem(
                src: 'assets/icons/navbar_walk.svg',
                active: 'assets/icons/navbar_walk_selected.svg',
                label: '산책',
              ),
              bottomNavbarItem(
                src: 'assets/icons/navbar_my.svg',
                active: 'assets/icons/navbar_my_selected.svg',
                label: '마이페이지',
              ),
            ],
            currentIndex: navigationShell.currentIndex,
            onTap: (int index) => navigationShell.goBranch(index),
          ),
        ),
      ),
    );
  }
}
