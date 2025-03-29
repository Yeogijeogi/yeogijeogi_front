import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/common/custom_button.dart';
import 'package:yeogijeogi/components/common/custom_text_button.dart';
import 'package:yeogijeogi/utils/palette.dart';

Future<void> showWalkEndDialog({
  required BuildContext context,
  required Function() onTapSave,
  required Function() onTapCancel,
}) async {
  await showDialog(
    context: context,
    builder:
        (context) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            padding: EdgeInsets.all(20.w),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('산책을 종료할까요?', style: Palette.headline),
                SizedBox(height: 24.h),

                // 산책 요약
                Text(
                  '안암역 - 성북천\n이동 거리 : 1.3km\n평균 속도 : 3km/h\n소요 시간 : 24분',
                  textAlign: TextAlign.center,
                  style: Palette.body.copyWith(color: Palette.onSurfaceVariant),
                ),
                SizedBox(height: 24.h),

                // 저장 버튼
                CustomButton(text: '산책 코스 저장하기', onTap: onTapSave),
                SizedBox(height: 20.h),

                // 저장 안하기 버튼
                CustomTextButton(text: '저장하지 않고 종료하기', onTap: onTapCancel),
              ],
            ),
          ),
        ),
  );
}
