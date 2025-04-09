import 'package:flutter/material.dart';
import 'package:yeogijeogi/models/objects/course.dart';

class CourseModel with ChangeNotifier {
  /// 사용자가 산책한 코스 리스트
  List<Course>? courses;

  /// 선택된 코스
  Course? course;

  /// 모델 초기화
  void reset() {
    courses = null;
    course = null;
  }
}
