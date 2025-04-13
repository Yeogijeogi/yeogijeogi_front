import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/custom_text_button.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';
import 'package:yeogijeogi/utils/palette.dart';

Future<void> showCustomDialog({
  /// 다이얼로그 타입
  required DialogType type,

  required BuildContext context,

  /// action 버튼 클릭시 호출 함수
  required Function() onTapAction,

  bool showCancel = true,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.all(20.w),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 제목
                Text(
                  type.title,
                  textAlign: TextAlign.center,
                  style: Palette.headline,
                ),
                SizedBox(height: 24.h),

                // 설명
                Text(
                  type.body,
                  textAlign: TextAlign.center,
                  style: Palette.body,
                ),
                SizedBox(height: 24.h),

                // 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (showCancel)
                      // 저장 안하기 버튼
                      CustomTextButton(
                        text: '취소',
                        style: Palette.callout.copyWith(
                          color: Palette.onSurfaceVariant,
                        ),
                        onTap: context.pop,
                      ),
                    SizedBox(width: 24.w),

                    // 액션 버튼
                    CustomTextButton(
                      text: type.action,
                      style: Palette.headline.copyWith(color: Palette.error),
                      onTap: onTapAction,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
  );
}
