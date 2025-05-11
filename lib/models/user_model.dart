import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yeogijeogi/utils/enums/login_type.dart';

class UserModel with ChangeNotifier {
  /// 사용자 uid
  String? uid;

  /// 이름
  String? name;

  /// 지금까지 산책한 총 거리 (m)
  double? walkDistance;

  /// 지금까지 산책한 총 시간 (분)
  int? walkTime;

  LoginType? loginType;

  /// 모델 초기화
  void reset() {
    uid = null;
    name = null;
    walkDistance = null;
    walkTime = null;
    loginType = null;
  }

  /// Firebase에서 받아온 사용자 데이터를 모델에 저장하는 함수
  void fromFirebaseUser(User user) {
    uid = user.uid;
    name = user.displayName;
    loginType = LoginType.fromProvider(user.providerData[0].providerId);
  }

  /// 서버에서 받아오는 사용자 데이터 저장
  void fromJson(Map<String, dynamic> json) {
    walkDistance = json['walk_distance'];
    walkTime = json['walk_time'];
  }

  /// 거리 업데이트
  void updateWalkDistance(double distance) {
    walkDistance = (walkDistance ?? 0) + distance;
    notifyListeners();
  }

  /// 시간 업데이트
  void updateWalkTime(int time) {
    walkTime = (walkTime ?? 0) + time;
    notifyListeners();
  }

  @override
  String toString() {
    return 'uid: $uid '
        'name: $name, '
        'walkDistance: $walkDistance '
        'walkTime: $walkTime '
        'loginType: $loginType';
  }
}
