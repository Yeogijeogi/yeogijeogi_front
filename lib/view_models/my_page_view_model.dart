import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/components/common/error_dialog.dart';
import 'package:yeogijeogi/components/my_page/nickname_dialog.dart';
import 'package:yeogijeogi/models/course_model.dart';
import 'package:yeogijeogi/models/user_model.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/custom_exception.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class MyPageViewModel with ChangeNotifier {
  UserModel userModel;
  CourseModel courseModel;
  WalkModel walkModel;
  BuildContext context;

  MyPageViewModel({
    required this.userModel,
    required this.courseModel,
    required this.walkModel,
    required this.context,
  }) {
    getAppVersion();

    userModel.addListener(notifyListeners);
  }

  /// 앱 버전
  String appVersion = '0.0.0';

  /// 페이지 로딩 상태
  bool isLoading = false;

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    notifyListeners();
  }

  void onTapNickname() async {
    // 닉네임 수정 다이얼로그 표시
    showNicknameDialog(
      context: context,
      hintText: userModel.name ?? '',
      onTapChange: (nickname) async {
        FirebaseAuth.instance.currentUser?.updateDisplayName(nickname);

        userModel.name = nickname;

        notifyListeners();
        context.pop();
      },
    );
  }

  /// 문의하기 클릭
  void onTapInquire() {
    launchUrl(
      Uri.parse(
        'https://wonhajin.notion.site/1c8bbe0d6aaa8095a9b3e89b4461547c',
      ),
    );
  }

  /// 개인정보 처리방침 클릭
  void onTapTerms() {
    launchUrl(
      Uri.parse(
        'https://wonhajin.notion.site/1c9bbe0d6aaa8056bd15e05c25b70499',
      ),
    );
  }

  /// 회원탈퇴
  void onTapDeleteAccount() {
    showCustomDialog(
      type: DialogType.deleteAccount,
      context: context,
      onTapAction: () async {
        try {
          isLoading = true;
          notifyListeners();

          context.pop();

          await API.deleteUser();
          await FirebaseAuth.instance.signOut();

          if (context.mounted) {
            // 모델 초기화
            userModel.reset();
            courseModel.reset();
            walkModel.reset();

            context.goNamed(AppRoute.login.name);
          }
        } catch (e) {
          if (context.mounted) {
            showErrorDialog(
              exception: CustomException.fromException(e, context),
              context: context,
            );
          }
        }

        isLoading = false;
        notifyListeners();
      },
    );
  }

  /// 로그아웃
  void onTapLogout() {
    showCustomDialog(
      type: DialogType.logout,
      context: context,
      onTapAction: () async {
        isLoading = true;
        notifyListeners();

        context.pop();

        // 로그아웃 후 login 페이지로 이동
        await FirebaseAuth.instance.signOut();

        // 모델 초기화
        userModel.reset();
        courseModel.reset();
        walkModel.reset();

        if (context.mounted) {
          userModel.reset();
          context.goNamed(AppRoute.login.name);
        }

        isLoading = false;
        notifyListeners();
      },
    );
  }
}
