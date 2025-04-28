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

  /// 전체 코스 불러오기
  void getCourses() async {
    // 코스 불러오기
    courses = await API.getCourse();

    // 첫 코스 선택
    if (courses.isNotEmpty) {
      course = courses[0];
    }
  }

  /// 선택된 코스 삭제
  Future<void> deleteSelectedCourse() async {
    if (course != null) {
      // 서버에서 삭제
      await API.deleteCourse(walkId: course!.id);

      // 모델에서 삭제 후 선택된 코스 업데이트
      courses.removeAt(0);
      if (courses.isNotEmpty) {
        course = courses[0];
      } else {
        course = null;
      }
    }
  }
}
