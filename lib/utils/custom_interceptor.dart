import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomInterceptor extends Interceptor {
  /// API 통신시 토큰 필요 여부
  final bool tokenRequired;

  CustomInterceptor({required this.tokenRequired});

  final _firebaseAuth = FirebaseAuth.instance;

  /// Firebase 인증을 위한 사용자 id token을 반환하는 함수
  ///
  /// 토큰이 만료되었다면 firebase에서 새로 발급한 토큰 반환, 만료되지 않았다면 현재 토큰을 반환
  /// </br> Firebase 로그인이 되어있지 않은 상태에서 토큰을 요청하면 `user-not-found` 오류 반환
  Future<String?> _getToken() async {
    String? token;

    if (_firebaseAuth.currentUser != null) {
      token = await _firebaseAuth.currentUser!.getIdToken();
    } else {
      throw ErrorDescription('user-not-found');
    }

    return token;
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 헤더에 토큰 추가
    if (tokenRequired) {
      String? token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiZGRkZCJ9.-6zBJUbhtGMFORTVFZhBOUS6upcRl3mevZ8rPpju3dk'; //await _getToken();
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
    debugPrint('${options.method} 요청: ${options.path}');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
    debugPrint('${response.requestOptions.path} 성공(${response.statusCode})');
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    debugPrint(
      '${err.requestOptions.path} 실패(${err.response?.statusCode}): ${err.response}',
    );
  }
}
