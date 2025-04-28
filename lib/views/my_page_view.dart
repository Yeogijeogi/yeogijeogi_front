import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_ink_well.dart';
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
          Text('${myPageViewModel.userModel.name}님', style: Palette.title),
          SizedBox(height: 8.h),

          Text('오늘도 열심히 산책을 하고 계시네요!', style: Palette.headline),
          SizedBox(height: 24.h),

          RecordContainer(
            distance: myPageViewModel.userModel.walkDistance ?? 0,
            time: myPageViewModel.userModel.walkTime ?? 0,
          ),
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

                // 닉네임 수정
                CustomInkWell(
                  onTap: myPageViewModel.onTapNickname,
                  backgroundColor: Palette.surface,
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    height: 36.h,
                    width: 128.w,
                    alignment: Alignment.center,
                    child: Text(
                      myPageViewModel.userModel.name ?? '',
                      style: Palette.body,
                    ),
                  ),
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
                InkWellTile(title: '앱 버전', action: myPageViewModel.appVersion),

                InkWellTile(title: '문의하기', onTap: myPageViewModel.onTapInquire),

                InkWellTile(
                  title: '개인정보 처리방침',
                  onTap: myPageViewModel.onTapTerms,
                ),
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
