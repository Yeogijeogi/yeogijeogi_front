import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/objects/course.dart';
import 'package:yeogijeogi/models/objects/recommendation.dart';
import 'package:yeogijeogi/models/objects/walk_point.dart';
import 'package:yeogijeogi/models/objects/walk_summary.dart';
import 'package:yeogijeogi/utils/custom_interceptor.dart';

class API {
  static final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['SERVER_API']!,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 10000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  /* USER API */

  /// user 생성 POST 요청
  /// token 반환
  static Future<void> postCreateUser() async {
    try {
      await _postApi('/user');
    } catch (e) {
      debugPrint('Error in postCreateUser: $e');
      throw Error();
    }
  }

  /// user 정보 GET 요청
  /// walk_distance와 walk_time 반환
  static Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final response = await _getApi('/user');

      if (response.data != null) {
        final data = response.data as Map<String, dynamic>;
        return data;
      } else {
        throw Error();
      }
    } catch (e) {
      debugPrint('Error in getUserInfo: $e');
      throw Error();
    }
  }

  /// user delete 요청
  /// true 반환
  static Future<void> deleteUser() async {
    try {
      await _deleteApi('/user');
    } catch (e) {
      debugPrint('Error in deleteUser: $e');
      throw Error();
    }
  }

  /* WALK API */

  /// 산책 코스 추천 api
  /// recommendation 리스트 반환
  static Future<List<Recommendation>> getRecommendadtion({
    required Coordinate coordinate,
    required int walkTime,
    required int mood,
    required int difficulty,
  }) async {
    final response = await _getApi(
      '/walk/recommend',
      queryParameters: {
        'latitude': coordinate.latitude,
        'longitude': coordinate.longitude,
        'walk_time': walkTime,
        'view': mood,
        'difficulty': difficulty,
      },
    );

    if (response != null) {
      return (response.data as List)
          .map((recommendation) => Recommendation.fromJson(recommendation))
          .toList();
    } else {
      throw Error();
    }
  }

  /// 코스 선택 후 산책 시작
  static Future<String> postWalkStart({
    required Coordinate coordinate,
    required Recommendation recommendation,
  }) async {
    final response = await _postApi(
      '/walk/start',
      jsonData: {
        'start_location': coordinate.toJson(),
        'start_name': recommendation.startName,
        'end_name': recommendation.name,
        'end_address': recommendation.address,
      },
    );

    if (response != null) {
      return response.data['walk_id'];
    } else {
      throw Error();
    }
  }

  /// 위치 정보 전달
  static Future<void> postWalkLocation({
    required String walkId,
    required List<WalkPoint> walkPoints,
  }) async {
    await _postApi(
      '/walk/location',
      jsonData: jsonEncode({
        'walk_id': walkId,
        'routes': walkPoints.map((point) => point.coordinate.toJson()).toList(),
      }),
    );
  }

  /// 산책 요약 불러오기
  static Future<WalkSummary> getWalkEnd(String walkId) async {
    final response = await _getApi(
      '/walk/end',
      queryParameters: {'walk_id': walkId},
    );

    if (response != null) {
      return WalkSummary.fromJson(response.data);
    } else {
      throw Error();
    }
  }

  /// 산책 종료
  static Future<void> postWalkEnd(
    String walkId,
    WalkSummary summary,
    String endAddress,
  ) async {
    await _postApi(
      '/walk/end',
      jsonData: {
        'walk_id': walkId,
        'start_name': summary.startName,
        'end_name': summary.endName,
        'end_address': endAddress,
        'distance': summary.distance,
        'time': summary.time,
      },
    );
  }

  /// 산책 업데이트
  static Future<void> patchWalkEnd(
    String walkId,
    int mood,
    int difficulty,
    String memo,
  ) async {
    await _patchApi(
      '/walk/end',
      jsonData: jsonEncode({
        'walk_id': walkId,
        'mood': mood,
        'difficulty': difficulty,
        'memo': memo,
      }),
    );
  }

  /* COURSE API */

  /// 전체 코스 정보 가져오기
  static Future<List<Course>> getCourse() async {
    try {
      final response = await _getApi('/course');

      if (response != null) {
        return (response.data as List)
            .map((course) => Course.fromJson(course))
            .toList();
      } else {
        throw Error();
      }
    } catch (e) {
      debugPrint('Error in getCourse: $e');
      throw Error();
    }
  }

  /// 코스 상세 정보 가져오기
  static Future<Map<String, dynamic>> getCourseDetail({
    required String walkId,
  }) async {
    final response = await _getApi(
      '/course/detail',
      queryParameters: {'walk_id': walkId},
    );

    if (response != null) {
      return response.data;
    } else {
      throw Error();
    }
  }

  /// 코스 삭제
  static Future<void> deleteCourse({required String walkId}) async {
    try {
      await _deleteApi('/course', jsonData: jsonEncode({'walk_id': walkId}));
    } catch (e) {
      debugPrint('Error in deleteCourse: $e');
      throw Error();
    }
  }

  /* BASE API (GET, POST, PATCH, DELETE) */

  /// ### API GET
  /// 데이터를 받아올 때 GET 요청을 보내는 함수
  ///
  /// `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  static Future<dynamic> _getApi(
    String endPoint, {
    String? jsonData,
    Map<String, dynamic>? queryParameters,
    bool tokenRequired = true,
  }) async {
    // dio interceptor을 사용해 에러 핸들링
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptor(tokenRequired: tokenRequired));
    return await dio.get(
      endPoint,
      data: jsonData,
      queryParameters: queryParameters,
    );
  }

  /// ### API POST
  /// 데이터 생성시 POST 요청을 보내는 함수
  ///
  /// `jsonData`가 있으면 request body를 포함해서 요청
  /// <br /> `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  static Future<dynamic> _postApi(
    String endPoint, {
    Object? jsonData,
    bool tokenRequired = true,
  }) async {
    // dio interceptor을 사용해 에러 핸들링
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptor(tokenRequired: tokenRequired));
    return await dio.post(endPoint, data: jsonData);
  }

  /// ### API PATCH
  /// 데이터 일부 수정시 PATCH 요청을 보내는 함수
  ///
  /// `jsonData`가 있으면 request body를 포함해서 요청
  /// <br /> `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  static Future<dynamic> _patchApi(
    String endPoint, {
    String? jsonData,
    bool tokenRequired = true,
  }) async {
    // dio interceptor을 사용해 에러 핸들링
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptor(tokenRequired: tokenRequired));
    return await dio.patch(endPoint, data: jsonData);
  }

  /// ### API DELETE
  /// 데이터 삭제시 DELETE 요청을 보내는 함수
  ///
  /// `jsonData`가 있으면 request body를 포함해서 요청
  /// <br /> `tokenRequired`를 `false`로 설정하면 API 요청시 토큰을 헤더에 포함시키지 않음.
  static Future<dynamic> _deleteApi(
    String endPoint, {
    String? jsonData,
    bool tokenRequired = true,
  }) async {
    // dio interceptor을 사용해 에러 핸들링
    dio.interceptors.clear();
    dio.interceptors.add(CustomInterceptor(tokenRequired: tokenRequired));
    return await dio.delete(endPoint, data: jsonData);
  }
}
