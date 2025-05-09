import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/main.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class CustomException implements Exception {
  final int statusCode;
  final String message;
  final Function()? action;

  CustomException({
    required this.statusCode,
    required this.message,
    this.action,
  });

  factory CustomException.fromException(Object error, BuildContext? context) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout) {
        return CustomException(
          statusCode: 500,
          message: '요청 시간을 초과했어요. 나중에 다시 시도해 주세요.',
        );
      }

      switch (error.response?.statusCode) {
        case 204:
          return CustomException(
            statusCode: 204,
            message: '이 서비스는 한국에서만 이용이 가능해요.',
          );

        case 400:
          return CustomException(
            statusCode: 400,
            message: '잘못된 접근이예요. 다시 시도해 주세요.',
          );

        case 401:
          return CustomException(
            statusCode: 401,
            message: '인증에 오류가 생겼어요. 다시 로그인 해 주세요.',
            action: () async {
              await FirebaseAuth.instance.signOut();
              userModel.reset();
              context?.goNamed(AppRoute.login.name);
            },
          );

        case 404:
          return CustomException(
            statusCode: 404,
            message: '요청하신 데이터를 찾을 수 없어요.',
          );

        default:
          return CustomException(statusCode: 500, message: '알 수 없는 오류가 발생했어요.');
      }
    } else {
      return CustomException(statusCode: 500, message: '알 수 없는 오류가 발생했어요.');
    }
  }
}
