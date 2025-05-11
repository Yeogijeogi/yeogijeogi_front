import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/objects/recommendation.dart';
import 'package:yeogijeogi/models/objects/walk_point.dart';
import 'package:yeogijeogi/models/objects/walk_summary.dart';
import 'package:yeogijeogi/utils/api.dart';

class WalkModel with ChangeNotifier {
  /// 산책 id
  String? id;

  /* 추천 */
  /// 추천 목적지 리스트
  List<Recommendation> recommendationList = [];

  /// 선택된 추천 목적지
  Recommendation? recommendation;

  /// 최근 1분동안 지나온 경로
  /// <br /> 10초에 한 번씩 경로 저장
  List<WalkPoint> walkPointList = [];

  /// 지도에 그려지는 산책 중인 경로
  List<NLatLng> pathList = [];

  /// 지금까지 산책한 내용 요약 정보
  WalkSummary? summary;

  /* 저장 */
  /// 산책 후 사진
  File? image;

  /* 온보딩 */
  /// 풍경 슬라이더 값
  double sceneryLevel = 0;

  /// 산책 슬라이더 값
  double walkingLevel = 0;

  /// 산책 시간
  Duration duration = Duration(hours: 0, minutes: 30);

  /// 모델 초기화
  void reset() {
    id = null;
    recommendationList.clear();
    recommendation = null;
    walkPointList.clear();
    pathList.clear();
    summary = null;
    image?.delete();
    image = null;
    sceneryLevel = 0;
    walkingLevel = 0;
    duration = Duration(hours: 0, minutes: 30);

    debugPrint('Reset WalkModel');
  }

  /// 온보딩 데이터 초기화
  void resetOnboardingData() {
    duration = Duration(hours: 0, minutes: 30);
    sceneryLevel = 0;
    walkingLevel = 0;
  }

  /// 위치 추가
  void addLocation(Coordinate coordinate) {
    // walkPointList 추가
    walkPointList.add(
      WalkPoint(walkId: id!, coordinate: coordinate, createdAt: DateTime.now()),
    );

    // pathList 추가
    pathList.add(coordinate.toNLatLng());

    debugPrint('WalkPoint added: $coordinate');
  }

  /// 추천 경로 선택
  Future<void> selectRecommendation(int index, Coordinate coordinate) async {
    // API 호출
    final String walkId = await API.postWalkStart(
      coordinate: coordinate,
      recommendation: recommendationList[index],
    );

    id = walkId;
    debugPrint('Walk ID : $id');

    recommendation = recommendationList[index];
  }

  /// 지난 경로 서버 전송
  Future<void> uploadWalkPoints() async {
    await API.postWalkLocation(walkId: id!, walkPoints: walkPointList);
    walkPointList.clear();
  }
}
