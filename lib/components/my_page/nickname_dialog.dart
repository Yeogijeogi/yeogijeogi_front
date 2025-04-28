import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/custom_text_button.dart';
import 'package:yeogijeogi/utils/palette.dart';

Future<void> showNicknameDialog({
  required BuildContext context,

  /// 힌트 (기존 닉네임)
  required String hintText,

  /// 변경 버튼 클릭시 호출 함수
  required Function(String) onTapChange,
}) async {
  final TextEditingController controller = TextEditingController();
  String errorText = '';

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (context) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          // 닉네임 에러 텍스트 수정을 위해 stateful로 구현
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
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
                      '변경할 닉네임을 입력하세요.',
                      textAlign: TextAlign.center,
                      style: Palette.headline,
                    ),
                    SizedBox(height: 24.h),

                    // 닉네임 수정
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Palette.surface,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: TextField(
                        autofocus: true,
                        controller: controller,
                        style: Palette.body,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 20.w,
                          ),
                          border: InputBorder.none,
                          hintText: hintText,
                          hintStyle: Palette.body.copyWith(
                            color: Palette.onSurfaceVariant,
                          ),
                          counterText: '',
                        ),
                        maxLines: 1,
                        maxLength: 16,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                    ),

                    // 에러 텍스트
                    if (errorText.isNotEmpty)
                      Container(
                        margin: EdgeInsets.fromLTRB(8.w, 8.h, 0, 0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          errorText,
                          style: Palette.caption.copyWith(color: Palette.error),
                        ),
                      ),
                    SizedBox(height: 24.h),

                    // 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // 취소 버튼
                        CustomTextButton(
                          text: '취소',
                          style: Palette.callout.copyWith(
                            color: Palette.onSurfaceVariant,
                          ),
                          onTap: context.pop,
                        ),
                        SizedBox(width: 24.w),

                        // 변경 버튼
                        CustomTextButton(
                          text: '변경',
                          style: Palette.headline.copyWith(
                            color: Palette.success,
                          ),
                          onTap: () {
                            // 비어있을 경우
                            if (controller.text.trim().isNotEmpty) {
                              onTapChange(controller.text.trim());
                            } else {
                              setState(() {
                                errorText = '닉네임을 입력하세요.';
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
  );
}
