import 'package:flutter/material.dart';
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

  /// 추천 목적지 리스트
  List<Recommendation> recommendationList = [
    Recommendation(
      location: Coordinate(longitude: 37.5880, latitude: 127.0201),
      name: '안암역1',
      address: '성북구 123',
      distance: 5,
      walks: 2000,
      time: 60,
      imgUrl: 'http://www.a.com',
      routes: [Coordinate(longitude: 0, latitude: 0)],
    ),

    Recommendation(
      location: Coordinate(longitude: 37.5863, latitude: 127.0923),
      name: '안암역2',
      address: '성북구 456',
      distance: 10,
      walks: 3000,
      time: 60,
      imgUrl: 'http://www.a.com',
      routes: [Coordinate(longitude: 0, latitude: 0)],
    ),

    Recommendation(
      location: Coordinate(longitude: 37.5852, latitude: 127.0319),
      name: '안암역3',
      address: '성북구 789',
      distance: 15,
      walks: 4000,
      time: 60,
      imgUrl: 'http://www.a.com',
      routes: [Coordinate(longitude: 0, latitude: 0)],
    ),
  ];

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
    recommendationList.clear();
  }

  /// 지난 경로 서버 전송
  void uploadWalkPoints() async {
    await API.postWalkLocation(walkId: id!, walkPoints: walkPointList);
    walkPointList.clear();
  }
}
