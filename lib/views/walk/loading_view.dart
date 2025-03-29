import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/walk/loading_view_model.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoadingViewModel loadingViewModel = context.watch<LoadingViewModel>();

    return CustomScaffold(
      canPop: false,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/animations/loading.json'),
            SizedBox(height: 40.h),

            Text('산책 코스를 찾고 있어요!', style: Palette.title),
            SizedBox(height: 8.h),

            Text('잠시만 기다려 주세요.', style: Palette.headline),
          ],
        ),
      ),
    );
  }
}
