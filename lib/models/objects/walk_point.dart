import 'package:yeogijeogi/models/objects/coordinate.dart';

class WalkPoint {
  final String walkId;
  final Coordinate coordinate;
  final DateTime createdAt;

  WalkPoint({
    required this.walkId,
    required this.coordinate,
    required this.createdAt,
  });
}
