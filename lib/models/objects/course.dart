import 'package:yeogijeogi/models/objects/coordinate.dart';

class Course {
  /// 산책 id
  final int id;

  /// 코스 위치
  final Coordinate location;

  /// 산책 종료 지점 이름
  final String name;

  /// 산책 종료 지점 주소
  final String address;

  /// 산책 거리 (km)
  final double distance;

  /// 산책 소요 시간 (분)
  final int time;

  /// 산책 코스 이미지
  String? imgUrl;

  /// 산책 분위기
  int? mood;

  /// 산책 난이도
  int? difficulty;

  /// 메모
  String? memo;

  Course({
    required this.id,
    required this.location,
    required this.name,
    required this.address,
    this.imgUrl,
    required this.distance,
    required this.time,
    this.mood,
    this.difficulty,
    this.memo,
  });

  /// 코스 기본 정보, 코스 생성
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['walkId'],
      location: json['location'],
      name: json['name'],
      address: json['address'],
      distance: json['distance'],
      time: json['time'],
    );
  }

  /// 코스 상세 정보 저장
  void fromCourseDetailJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'];
    mood = json['mood'];
    difficulty = json['difficulty'];
    memo = json['memo'];
  }
}
