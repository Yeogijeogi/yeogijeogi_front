import 'package:flutter/material.dart';
import 'package:yeogijeogi/models/objects/course.dart';
import 'package:yeogijeogi/utils/api.dart';

class CourseModel with ChangeNotifier {
  /// 사용자가 산책한 코스 리스트
  List<Course> courses = [];

  /// 선택된 코스
  Course? course;

  /// 모델 초기화
  void reset() {
    courses.clear();
    course = null;
  }

  void getCourses() async {
    // 코스 불러오기
    courses = await API.getCourse();

    // 첫 코스 선택
    if (courses.isNotEmpty) {
      course = courses[0];
    }
  }
}
