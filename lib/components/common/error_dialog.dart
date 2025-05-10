import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/custom_text_button.dart';
import 'package:yeogijeogi/utils/custom_exception.dart';
import 'package:yeogijeogi/utils/palette.dart';

Future<void> showErrorDialog({
  /// 다이얼로그 타입
  required CustomException exception,

  required BuildContext context,

  Function()? action,
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
            decoration: BoxDecoration(
              color: Palette.container,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 제목
                Text(
                  '오류가 발생했어요. (${exception.statusCode})',
                  textAlign: TextAlign.center,
                  style: Palette.headline,
                ),
                SizedBox(height: 24.h),

                // 설명
                Text(
                  exception.message,
                  textAlign: TextAlign.center,
                  style: Palette.body,
                ),
                SizedBox(height: 24.h),

                // 버튼
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButton(
                    text: '확인',
                    style: Palette.headline.copyWith(color: Palette.error),
                    onTap: () {
                      exception.action?.call();
                      action?.call();
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}
