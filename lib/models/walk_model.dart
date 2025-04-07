import 'package:flutter/material.dart';

class WalkModel with ChangeNotifier {
  /// 시작 주소
  String? startName;

  /// 도착 주소
  String? endName;

  /// 시간
  int? time;

  /// 평균 속도

  /// 거리
  double? distance;

  /// 분위기
  int? mood;

  /// 산책 강도
  int? difficulty;

  /// 메모
  String? memo;
}
