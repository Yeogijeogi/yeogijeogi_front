import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeogijeogi/models/user_model.dart';
import 'package:yeogijeogi/models/course_model.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/app_router.dart';
import 'package:yeogijeogi/utils/custom_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: kReleaseMode ? '.env.dev' : '.env.prod');
  await Firebase.initializeApp();

  // 네이버 지도 초기화
  await FlutterNaverMap().init(
    clientId: dotenv.env['NAVER_CLIENT_ID'],
    onAuthFailed: (ex) => debugPrint('Error initializing Naver Map: $ex'),
  );

  // 가능하다면 자동 로그인 진행
  await autoLogin();

  runApp(const MainApp());
}

/// Firebase 로그인 정보가 있는지 확인 후 있다면 사용자 정보를 모델에 저장하는 함수
Future<void> autoLogin() async {
  // Firebase 로그인이 된 상태라면 서버에서 사용자 정보 요청
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // 사용자가 존재한다면 모델에 데이터 저장
    userModel.fromFirebaseUser(user);

    final userInfo = await API.getUserInfo();
    userModel.fromJson(userInfo);

    debugPrint('Auto login to user ${userModel.name}');

    // Course 정보 불러오기
    courseModel.getCourses();
  } else {
    // 사용자가 존재하지 않는다면 모델 리셋 (혹시 모를 상황 대비)
    userModel.reset();
  }
}

// 모델
final UserModel userModel = UserModel();
final WalkModel walkModel = WalkModel();
final CourseModel courseModel = CourseModel();

// 라우터
final _router = AppRouter.getRouter(userModel, walkModel, courseModel);

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
