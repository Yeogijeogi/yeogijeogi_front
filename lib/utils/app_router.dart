import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';
import 'package:yeogijeogi/view_models/home_view_model.dart';
import 'package:yeogijeogi/view_models/loading_view_model.dart';
import 'package:yeogijeogi/view_models/login_view_model.dart';
import 'package:yeogijeogi/view_models/walk/walk_start_view_model.dart';
import 'package:yeogijeogi/views/home_view.dart';
import 'package:yeogijeogi/views/loading_view.dart';
import 'package:yeogijeogi/views/login_view.dart';
import 'package:yeogijeogi/views/walk/walk_start_view.dart';

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
      routes: [
        // 로그인
        GoRoute(
          path: '/login',
          name: AppRoute.login.name,
          builder:
              (context, state) => ChangeNotifierProvider(
                create: (context) => LoginViewModel(context: context),
                child: const LoginView(),
              ),
        ),
        // 홈
        GoRoute(
          path: '/home',
          name: AppRoute.home.name,
          builder:
              (context, state) => ChangeNotifierProvider(
                create: (context) => HomeViewModel(context: context),
                child: const HomeView(),
              ),
          routes: [
            GoRoute(
              path: 'loading',
              name: AppRoute.loading.name,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => LoadingViewModel(context: context),
                    child: const LoadingView(),
                  ),
            ),
            GoRoute(
              path: 'walk-start',
              name: AppRoute.walkStart.name,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => WalkStartViewModel(context: context),
                    child: const WalkStartView(),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
