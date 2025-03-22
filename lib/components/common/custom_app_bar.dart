import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yeogijeogi/utils/enums/app_bar_leading_type.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// 제목
  final String? title;

  /// Leading 아이콘 타입
  final AppBarLeadingType? leading;

  /// 마이페이지 아이콘
  final bool action;

  /// ### AppBar에서 필요한 기능들을 적용한 위젯
  /// `title` : AppBar 타이틀
  ///
  /// `leading` : 좌측 leading 부분 표시할 아이콘
  ///
  /// `action` : 우측 마이페이지 아이콘 표시 여부
  const CustomAppBar({
    super.key,
    this.title,
    this.leading,
    this.action = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppBar(
        title: title != null ? Text(title!) : null,
        centerTitle: true,
        leading:
            leading != null
                ? Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => leading!.onTap(context),
                    child: SvgPicture.asset(
                      leading!.icon,
                      width: leading!.size,
                      height: leading!.size,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                )
                : null,
        actions: [
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/icons/profile.svg',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
