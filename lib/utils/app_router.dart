import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/bottom_navbar.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';
import 'package:yeogijeogi/view_models/course_view_model.dart';
import 'package:yeogijeogi/view_models/walk/onboarding_view_model.dart';
import 'package:yeogijeogi/view_models/walk/loading_view_model.dart';
import 'package:yeogijeogi/view_models/login_view_model.dart';
import 'package:yeogijeogi/view_models/walk/save_view_model.dart';
import 'package:yeogijeogi/view_models/walk/walk_start_view_model.dart';
import 'package:yeogijeogi/view_models/my_page_view_model.dart';
import 'package:yeogijeogi/view_models/walk/walk_view_model.dart';
import 'package:yeogijeogi/views/course_view.dart';
import 'package:yeogijeogi/views/walk/onboarding_view.dart';
import 'package:yeogijeogi/views/walk/loading_view.dart';
import 'package:yeogijeogi/views/login_view.dart';
import 'package:yeogijeogi/views/walk/save_view.dart';
import 'package:yeogijeogi/views/walk/walk_start_view.dart';
import 'package:yeogijeogi/views/my_page_view.dart';
import 'package:yeogijeogi/views/walk/walk_view.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootKey = GlobalKey<NavigatorState>();

  static GoRouter getRouter() {
    return GoRouter(
      initialLocation: '/login',
      navigatorKey: _rootKey,
      redirect: (_, state) {
        // 로그인된 사용자가 있는지 확인
        final User? user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          // 로그인된 사용자가 없으면 로그인 화면으로 이동
          return '/login';
        } else if (state.fullPath == '/login') {
          // 로그인 화면에서 로그인 된 사용자가 있으면 홈 화면으로 이동
          return '/onboarding';
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

            // 산책
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/onboarding',
                  name: AppRoute.onboarding.name,
                  builder:
                      (context, _) => ChangeNotifierProvider(
                        create:
                            (context) => OnboardingViewModel(context: context),
                        child: const OnboardingView(),
                      ),
                  routes: [
                    GoRoute(
                      path: 'loading',
                      name: AppRoute.loading.name,
                      parentNavigatorKey: _rootKey,
                      builder:
                          (context, _) => ChangeNotifierProvider(
                            create:
                                (context) => LoadingViewModel(context: context),
                            child: const LoadingView(),
                          ),
                    ),
                    GoRoute(
                      path: 'walk-start',
                      name: AppRoute.walkStart.name,
                      builder:
                          (context, state) => ChangeNotifierProvider(
                            create:
                                (context) =>
                                    WalkStartViewModel(context: context),
                            child: const WalkStartView(),
                          ),
                      routes: [
                        GoRoute(
                          path: 'walk',
                          name: AppRoute.walk.name,
                          parentNavigatorKey: _rootKey,
                          builder:
                              (context, state) => ChangeNotifierProvider(
                                create:
                                    (context) =>
                                        WalkViewModel(context: context),
                                child: const WalkView(),
                              ),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'save',
                      name: AppRoute.save.name,
                      parentNavigatorKey: _rootKey,
                      builder:
                          (context, state) => ChangeNotifierProvider(
                            create:
                                (context) => SaveViewModel(context: context),
                            child: const SaveView(),
                          ),
                    ),
                  ],
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
                        create: (context) => MyPageViewModel(context: context),
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
