import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:yeogijeogi/components/common/error_dialog.dart';
import 'package:yeogijeogi/models/user_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/custom_exception.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class LoginViewModel with ChangeNotifier {
  UserModel userModel;
  BuildContext context;

  LoginViewModel({required this.userModel, required this.context});

  /// Firebase
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isLoading = false;

  /// 구글 로그인
  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 로딩 시작
      isLoading = true;
      notifyListeners();

      // OAuth credential 생성
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase 인증
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      final User? user = userCredential.user;

      try {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await API.postCreateUser();
        }

        if (user != null) {
          userModel.fromFirebaseUser(user);

          final userInfo = await API.getUserInfo();
          userModel.fromJson(userInfo);

          isLoading = false;
          notifyListeners();

          // 홈 화면 이동
          if (context.mounted) context.goNamed(AppRoute.onboarding.name);
        }
      } catch (e) {
        if (context.mounted) {
          showErrorDialog(
            exception: CustomException.fromException(e, context),
            context: context,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
      debugPrint('FirebaseAuthException in _googleLogin: ${e.code}');

      if (context.mounted) {
        showErrorDialog(
          exception: CustomException.fromException(e, context),
          context: context,
        );
      }
    } catch (e) {
      debugPrint('Error in _googleLogin: $e');

      if (context.mounted) {
        showErrorDialog(
          exception: CustomException.fromException(e, context),
          context: context,
        );
      }
    }

    isLoading = false;
    notifyListeners();
  }

  /// Apple 로그인
  void signInWithApple() async {
    try {
      final AuthorizationCredentialAppleID appleCredential =
          await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );

      // 로딩 시작
      isLoading = true;
      notifyListeners();

      // OAuth credential 생성
      final OAuthCredential credential = OAuthProvider('apple.com').credential(
        accessToken: appleCredential.authorizationCode,
        idToken: appleCredential.identityToken,
      );

      // Firebase 인증
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      final User? user = userCredential.user;

      try {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await API.postCreateUser();
        }

        if (user != null) {
          userModel.fromFirebaseUser(user);

          final userInfo = await API.getUserInfo();
          userModel.fromJson(userInfo);

          isLoading = false;
          notifyListeners();

          // 홈 화면 이동
          if (context.mounted) context.goNamed(AppRoute.onboarding.name);
        }
      } catch (e) {
        if (context.mounted) {
          showErrorDialog(
            exception: CustomException.fromException(e, context),
            context: context,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException in _appleLogin: ${e.code}');
      if (context.mounted) {
        showErrorDialog(
          exception: CustomException.fromException(e, context),
          context: context,
        );
      }
    } catch (e) {
      debugPrint('Error in _appleLogin: $e');
      if (context.mounted) {
        showErrorDialog(
          exception: CustomException.fromException(e, context),
          context: context,
        );
      }
    }

    isLoading = false;
    notifyListeners();
  }
}
