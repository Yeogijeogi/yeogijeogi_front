import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/utils/utils.dart';

class Course {
  /// 산책 id
  final String id;

  /// 코스 위치
  final Coordinate location;

  /// 산책 종료 지점 이름
  final String name;

  /// 산책 종료 지점 주소
  final String address;

  /// 산책 거리 (m)
  final double distance;

  /// 산책 소요 시간 (분)
  final int time;

  /// 산책 평균 속도
  double? speed;

  /// 산책 코스 이미지
  String? imgUrl;

  /// 산책 분위기
  double? mood;

  /// 산책 난이도
  double? difficulty;

  /// 메모
  String? memo;

  Course({
    required this.id,
    required this.location,
    required this.name,
    required this.address,
    required this.time,
    required this.distance,
    this.speed,
    this.imgUrl,
    this.mood,
    this.difficulty,
    this.memo,
  });

  /// 코스 기본 정보, 코스 생성
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['walk_id'],
      location: Coordinate.fromJson(json['location']),
      name: json['name'],
      address: json['address'],
      distance: json['distance'],
      time: json['time'],
      speed: calAvgSpeed(json['distance'], json['time']),
    );
  }

  /// 코스 상세 정보 저장
  Future<void> fromCourseDetailJson(
    Map<String, dynamic> json,
    String userId,
  ) async {
    final Reference storage = FirebaseStorage.instance.ref(
      'images/$userId/$id.png',
    );
    imgUrl = await storage.getDownloadURL();

    mood = json['mood'].toDouble();
    difficulty = json['difficulty'].toDouble();
    memo = json['memo'];
  }

  NMarker toNMarker() {
    return NMarker(
      id: id,
      position: location.toNLatLng(),
      icon: NOverlayImage.fromAssetImage('assets/icons/marker.png'),
      anchor: NPoint.relativeCenter,
    );
  }

  @override
  String toString() {
    return 'id: $id, '
        'location: $location, '
        'name: $name, '
        'address: $address, '
        'distance: $distance, '
        'time: $time, '
        'speed: $speed, '
        'imgUrl: $imgUrl, '
        'mood: $mood, '
        'difficulty: $difficulty, '
        'memo: $memo';
  }
}
