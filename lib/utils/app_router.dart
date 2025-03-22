import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/bottom_navbar.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';
import 'package:yeogijeogi/view_models/course_view_model.dart';
import 'package:yeogijeogi/view_models/home_view_model.dart';
import 'package:yeogijeogi/view_models/loading_view_model.dart';
import 'package:yeogijeogi/view_models/login_view_model.dart';
import 'package:yeogijeogi/view_models/my_page_view_model.dart';
import 'package:yeogijeogi/views/course_view.dart';
import 'package:yeogijeogi/views/home_view.dart';
import 'package:yeogijeogi/views/loading_view.dart';
import 'package:yeogijeogi/views/login_view.dart';
import 'package:yeogijeogi/views/my_page_view.dart';

class AppRouter {
  static GoRouter getRouter() {
    return GoRouter(
      initialLocation: '/login',
      redirect: (_, state) {
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
              (context, _) => ChangeNotifierProvider(
                create: (context) => LoginViewModel(context: context),
                child: const LoginView(),
              ),
        ),

        StatefulShellRoute.indexedStack(
          builder:
              (_, __, navigationShell) =>
                  BottomNavbar(navigationShell: navigationShell),
          branches: [
            // 산책
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  name: AppRoute.home.name,
                  builder:
                      (context, _) => ChangeNotifierProvider(
                        create: (context) => HomeViewModel(context: context),
                        child: const HomeView(),
                      ),
                  routes: [
                    GoRoute(
                      path: 'loading',
                      name: AppRoute.loading.name,
                      builder:
                          (context, _) => ChangeNotifierProvider(
                            create:
                                (context) => LoadingViewModel(context: context),
                            child: const LoadingView(),
                          ),
                    ),
                  ],
                ),
              ],
            ),

            // 코스
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/course',
                  name: AppRoute.course.name,
                  builder:
                      (context, _) => ChangeNotifierProvider(
                        create: (context) => CourseViewModel(),
                        child: const CourseView(),
                      ),
                ),
              ],
            ),

            // 마이페이지
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/my',
                  name: AppRoute.my.name,
                  builder:
                      (context, _) => ChangeNotifierProvider(
                        create: (context) => MyPageViewModel(),
                        child: const MyPageView(),
                      ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
