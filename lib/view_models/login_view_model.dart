import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class LoginViewModel with ChangeNotifier {
  BuildContext context;

  LoginViewModel({required this.context});

  /// Firebase
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// 구글 로그인
  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // OAuth credential 생성
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase 인증
      await _firebaseAuth.signInWithCredential(credential);

      // 홈 화면 이동
      if (context.mounted) context.goNamed(AppRoute.onboarding.name);
    } on FirebaseAuthException catch (e) {
      // https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
      debugPrint('FirebaseAuthException in _googleLogin: ${e.code}');
    } catch (e) {
      debugPrint('Error in _googleLogin: $e');
    }
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

      // OAuth credential 생성
      final OAuthCredential credential = OAuthProvider('apple.com').credential(
        accessToken: appleCredential.authorizationCode,
        idToken: appleCredential.identityToken,
      );

      // Firebase 인증
      await _firebaseAuth.signInWithCredential(credential);

      // 홈 화면 이동
      if (context.mounted) context.goNamed(AppRoute.onboarding.name);
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException in _appleLogin: ${e.code}');
    } catch (e) {
      debugPrint('Error in _appleLogin: $e');
    }
  }
}
