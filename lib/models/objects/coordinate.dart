import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:location/location.dart';

class Coordinate {
  /// 경도
  final double longitude;

  /// 위도
  final double latitude;

  Coordinate({required this.longitude, required this.latitude});

  factory Coordinate.fromLocationData(LocationData location) {
    return Coordinate(
      longitude: double.parse((location.longitude ?? 0).toStringAsFixed(4)),
      latitude: double.parse((location.latitude ?? 0).toStringAsFixed(4)),
    );
  }

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(longitude: json['longitude'], latitude: json['latitude']);
  }

  factory Coordinate.fromNLatLng(NLatLng nLatLng) {
    return Coordinate(longitude: nLatLng.longitude, latitude: nLatLng.latitude);
  }

  Map<String, dynamic> toJson() {
    return {'longitude': longitude, 'latitude': latitude};
  }

  NLatLng toNLatLng() {
    return NLatLng(latitude, longitude);
  }

  @override
  String toString() {
    return 'longitude: $longitude, '
        'latitude: $latitude';
  }
}
