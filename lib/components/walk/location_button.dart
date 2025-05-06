import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yeogijeogi/components/common/custom_ink_well.dart';
import 'package:yeogijeogi/utils/palette.dart';

class LocationButton extends StatelessWidget {
  // 따라가기 활성화 여부
  final bool isLocationActive;

  // 버튼 탭
  final Function() onTap;

  const LocationButton({
    super.key,
    required this.isLocationActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      margin: EdgeInsets.only(left: 20.w),
      child: CustomInkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        backgroundColor: Palette.surface,
        child: SvgPicture.asset(
          isLocationActive
              ? 'assets/icons/location_active.svg'
              : 'assets/icons/location.svg',
          width: 32.w,
          height: 32.w,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
