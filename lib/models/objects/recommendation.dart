import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';

class Recommendation {
  /// 목적지 경도, 위도
  final Coordinate location;

  /// 출발지 이름
  final String startName;

  /// 목적지 이름
  final String name;

  /// 목적지 주소
  final String address;

  /// 거리
  final double distance;

  /// 걸음수
  final int walks;

  /// 시간
  final int time;

  /// 지도에 표시될 경로 좌표 리스트
  final List<Coordinate> routes;

  final List<NLatLng> path;

  Recommendation({
    required this.location,
    required this.startName,
    required this.name,
    required this.address,
    required this.distance,
    required this.walks,
    required this.time,
    required this.routes,
    required this.path,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    final routes =
        (json['routes'] as List)
            .map((route) => Coordinate.fromJson(route))
            .toList();

    return Recommendation(
      location: Coordinate.fromJson(json['location']),
      startName: json['start_name'],
      name: json['name'],
      address: json['address'],
      distance: (json['distance'] as num).toDouble(),
      walks: (json['walks'] as num).toInt(),
      time: json['time'],
      routes: routes,
      path: routes.map((r) => r.toNLatLng()).toList(),
    );
  }
}
