import 'package:yeogijeogi/utils/utils.dart';

class WalkSummary {
  final String startName;
  final String endName;
  final double distance;
  final double speed;
  final int time;

  WalkSummary({
    required this.startName,
    required this.endName,
    required this.distance,
    required this.speed,
    required this.time,
  });

  factory WalkSummary.fromJson(Map<String, dynamic> json) {
    return WalkSummary(
      startName: json['start_name'],
      endName: json['end_name'],
      distance: toFixedDigits(json['distance']),
      speed: calAvgSpeed(json['distance'], json['time']),
      time: json['time'],
    );
  }
}
