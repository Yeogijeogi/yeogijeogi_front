import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/components/common/custom_button.dart';
import 'package:yeogijeogi/models/objects/walk_summary.dart';
import 'package:yeogijeogi/utils/palette.dart';

Future<void> showWalkEndDialog({
  required BuildContext context,
  required WalkSummary summary,
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
                  '${summary.startName} - ${summary.endName}\n이동 거리 : ${summary.distance}km\n평균 속도 : ${summary.speed}km/h\n소요 시간 : ${summary.time}분',
                  textAlign: TextAlign.center,
                  style: Palette.body.copyWith(color: Palette.onSurfaceVariant),
                ),
                SizedBox(height: 24.h),

                // 저장 버튼
                CustomButton(text: '산책 코스 저장하기', onTap: onTapSave),
              ],
            ),
          ),
        ),
  );
}
