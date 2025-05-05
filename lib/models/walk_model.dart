import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/objects/recommendation.dart';
import 'package:yeogijeogi/models/objects/walk_point.dart';
import 'package:yeogijeogi/utils/api.dart';

class WalkModel with ChangeNotifier {
  /// 산책 id
  String? id;

  /// 시작 주소
  String? startName;

  /// 도착 주소
  String? endName;

  /// 시간
  int? time;

  /// 평균 속도
  double? averageSpeed;

  /// 거리
  double? distance;

  /// 분위기
  int? mood;

  /// 산책 강도
  int? difficulty;

  /// 메모
  String? memo;

  /// 경로 좌표 리스트
  List<Coordinate>? routes;

  /// 최근 1분동안 지나온 경로
  /// <br /> 10초에 한 번씩 경로 저장
  List<WalkPoint> walkPointList = [];

  /// 지도에 그려지는 경로
  List<NLatLng> pathList = [];

  /// 산책 후 사진
  File? image;

  /// 추천 목적지 리스트
  List<Recommendation> recommendationList = [];

  /// 추천 경로 리스트
  List<NLatLng> recommendationPathList = [];

  /// 모델 초기화
  void reset() {
    id = null;
    startName = null;
    endName = null;
    time = null;
    averageSpeed = null;
    distance = null;
    mood = null;
    difficulty = null;
    memo = null;
    routes = null;
    walkPointList.clear();
    recommendationList.clear();
    pathList.clear();
    image?.delete();
    image = null;

    debugPrint('Reset WalkModel');
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

  /// 추천 경로 추가
  void addRecommendationLocation(List<Coordinate> routes) {
    recommendationPathList = [];
    for (final coordinate in routes) {
      recommendationPathList.add(coordinate.toNLatLng());
    }

    debugPrint('Recommendation routes added: $routes');
  }

  /// 추천 경로 선택
  void selectRecommendation(int index, Coordinate coordinate) async {
    // API 호출
    final String walkId = await API.postWalkStart(
      coordinate: coordinate,
      recommendation: recommendationList[index],
    );

    id = walkId;
    debugPrint('Walk ID : $id');

    routes = recommendationList[index].routes;
    endName = recommendationList[index].name;
    distance = recommendationList[index].distance;
    time = recommendationList[index].time;
    recommendationList.clear();
  }

  /// 지난 경로 서버 전송
  Future<void> uploadWalkPoints() async {
    await API.postWalkLocation(walkId: id!, walkPoints: walkPointList);
    walkPointList.clear();
  }
}
