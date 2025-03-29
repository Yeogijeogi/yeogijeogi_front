import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/utils/app_router.dart';
import 'package:yeogijeogi/utils/custom_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();

  // 네이버 지도 초기화
  await NaverMapSdk.instance.initialize(
    clientId: dotenv.env['NAVER_CLIENT_ID'],
    onAuthFailed: (ex) => debugPrint('Error initializing Naver Map: $ex'),
  );

  runApp(const MainApp());
}

// 라우터
final _router = AppRouter.getRouter();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852), // 디자인 기준 사이즈 (iPhone 14 pro)
      minTextAdapt: true, // 텍스트 크기 자동 조절
      splitScreenMode: true, // 태블릿 지원
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: _router, // 기존 라우터 유지
          theme: CustomThemeData.light, // 기존 테마 유지
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
