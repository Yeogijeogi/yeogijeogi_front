import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/common/custom_text_button.dart';
import 'package:yeogijeogi/components/my_page/ink_well_tile.dart';
import 'package:yeogijeogi/components/my_page/record_container.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/my_page_view_model.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPageViewModel myPageViewModel = context.watch<MyPageViewModel>();

    return CustomScaffold(
      isLoading: myPageViewModel.isLoading,
      title: '마이페이지',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('원하진님', style: Palette.title),
          SizedBox(height: 8.h),

          Text('오늘도 열심히 산책을 하고 계시네요!', style: Palette.headline),
          SizedBox(height: 24.h),

          RecordContainer(),
          SizedBox(height: 24.h),

          Text('계정', style: Palette.headline),
          SizedBox(height: 16.h),

          Container(
            width: double.infinity,
            height: 64.h,
            decoration: BoxDecoration(
              color: Palette.container,
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('닉네임', style: Palette.body),
                Container(
                  height: 36.h,
                  width: 128.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Palette.surface,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text('원하진', style: Palette.body),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          Text('이용안내', style: Palette.headline),
          SizedBox(height: 16.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.h),
            decoration: BoxDecoration(
              color: Palette.container,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                InkWellTile(title: '앱 버전', action: '1.0.0'),

                InkWellTile(title: '문의하기', onTap: () {}),

                InkWellTile(title: '개인정보 처리방침', onTap: () {}),
                // Container(
                //   height: 40.h,
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 20.w,
                //     vertical: 8.h,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text('앱 버전', style: Palette.body),
                //       Text(
                //         '1.0.0',
                //         style: Palette.body.copyWith(
                //           color: Palette.onSurfaceVariant,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   height: 40.h,
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 20.w,
                //     vertical: 8.h,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text('문의하기', style: Palette.body),
                //       SizedBox(
                //         width: 24.w,
                //         height: 24.h,
                //         child: IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.arrow_forward_ios_rounded,
                //             size: 24.h,
                //             color: Palette.onSurfaceVariant,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Container(
                //   height: 40.h,
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 20.w,
                //     vertical: 8.h,
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text('개인정보 처리방침', style: Palette.body),
                //       SizedBox(
                //         width: 24.w,
                //         height: 24.h,
                //         child: IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.arrow_forward_ios_rounded,
                //             size: 24.h,
                //             color: Palette.onSurfaceVariant,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButton(
                text: '회원탈퇴',
                onTap: myPageViewModel.onTapDeleteAccount,
              ),
              SizedBox(width: 16.w),

              // Divider
              Container(
                width: 1,
                height: 8.h,
                decoration: BoxDecoration(
                  color: Palette.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),
              SizedBox(width: 16.w),

              CustomTextButton(
                text: '로그아웃',
                onTap: myPageViewModel.onTapLogout,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
