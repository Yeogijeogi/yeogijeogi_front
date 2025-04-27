import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_button.dart';
import 'package:yeogijeogi/components/common/custom_ink_well.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/walk/walk_view_model.dart';

class WalkView extends StatelessWidget {
  const WalkView({super.key});

  @override
  Widget build(BuildContext context) {
    final WalkViewModel walkViewModel = context.watch<WalkViewModel>();

    return CustomScaffold(
      isLoading: walkViewModel.isLoading,
      hasPadding: false,
      useSafeArea: false,
      canPop: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 지도
          NaverMap(
            options: walkViewModel.options,
            onMapReady: walkViewModel.onMapReady,
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 내 위치 버튼
              Container(
                width: 40.w,
                height: 40.w,
                margin: EdgeInsets.only(left: 20.w),
                child: CustomInkWell(
                  onTap: walkViewModel.moveToCurrentLocation,
                  borderRadius: BorderRadius.circular(20.r),
                  backgroundColor: Palette.surface,
                  child: SvgPicture.asset(
                    'assets/icons/location.svg',
                    width: 32.w,
                    height: 32.w,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // 종료 버튼
              SafeArea(
                top: false,
                bottom: true,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomButton(
                    text: '산책 종료하기',
                    onTap: walkViewModel.onTapEnd,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
