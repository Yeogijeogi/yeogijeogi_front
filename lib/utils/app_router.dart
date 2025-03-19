import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter getRouter() {
    return GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        // 로그인된 사용자가 있는지 확인
        final User? user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          // 로그인된 사용자가 없으면 로그인 화면으로 이동
          return '/login';
        } else if (state.fullPath == '/login') {
          // 로그인 화면에서 로그인 된 사용자가 있으면 홈 화면으로 이동
          return '/home';
        } else {
          // 그 외 상황은 요청한 페이지로 이동
          return null;
        }
      },
      routes: [],
    );
  }
}
