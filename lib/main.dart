import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yeogijeogi/utils/app_router.dart';
import 'package:yeogijeogi/utils/custom_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

// 라우터
final _router = AppRouter.getRouter();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: CustomThemeData.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
