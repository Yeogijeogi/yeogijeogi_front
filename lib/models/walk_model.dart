import 'package:flutter/material.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/objects/recommendation.dart';
import 'package:yeogijeogi/models/objects/walk_point.dart';

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
  List<WalkPoint>? walkPointList;

  /// 추천 목적지 리스트
  List<Recommendation>? recommendationList;

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
    recommendationList = null;
    routes = null;
    walkPointList = null;
  }

  void getAvgSpeed() {
    if (time != null && time != 0 && distance != null) {
      averageSpeed = distance! / time!;
    }
  }
}
