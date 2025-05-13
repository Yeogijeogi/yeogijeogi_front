import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:yeogijeogi/components/common/error_dialog.dart';
import 'package:yeogijeogi/models/objects/course.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/custom_exception.dart';

class CourseModel with ChangeNotifier {
  /// 사용자가 산책한 코스 리스트
  List<Course> courses = [];

  /// 선택된 코스
  Course? course;

  /// 마커 리스트
  List<NMarker> markers = [];

  /// 선택된 마커
  NMarker? marker;

  /// 네이버 지도 컨트롤러
  NaverMapController? naverMapController;

  /// 모델 초기화
  void reset() {
    courses.clear();
    course = null;
    markers.clear();
    marker = null;
    naverMapController = null;
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

  /// 코스 선택
  void selectCourseById(String id) {
    // 기존 마커 원상복귀
    if (marker != null) {
      marker!.setIcon(NOverlayImage.fromAssetImage('/assets/icons/marker.png'));
      marker!.setAnchor(NPoint.relativeCenter);
    }

    course = courses.firstWhere((c) => c.id == id);
  }

  /// 마커 선택
  void selectMarker(NMarker marker) {
    this.marker = marker;
    marker.setIcon(
      NOverlayImage.fromAssetImage('/assets/icons/marker_selected.png'),
    );
    marker.setAnchor(NPoint(0.5, 1));
  }

  /// 선택된 코스 삭제
  Future<(double distance, int time)?> deleteSelectedCourse(
    BuildContext context,
  ) async {
    if (course != null) {
      try {
        // 거리, 시간 임시 저장
        final double distance = course!.distance;
        final int time = course!.time;

        // 서버에서 삭제
        await API.deleteCourse(walkId: course!.id);

        // 모델에서 삭제 후 선택된 코스 업데이트
        courses.remove(course);
        markers.remove(marker);

        if (courses.isNotEmpty) {
          course = courses[0];
          marker = markers[0];
          selectMarker(marker!);
        } else {
          course = null;
        }

        return (distance, time);
      } catch (e) {
        if (context.mounted) {
          await showErrorDialog(
            exception: CustomException.fromException(e, context),
            context: context,
          );
        }
      }
    }

    return null;
  }

  /// 지도에 마커 그리기
  void drawMarkers() {
    if (naverMapController != null &&
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      for (Course course in courses) {
        final NMarker marker = course.toNMarker();
        marker.setOnTapListener(onTapMarker);
        try {
          naverMapController!.addOverlay(marker);
        } catch (e) {
          debugPrint("지도 마커 추가 실패: $e");
        }
        markers.add(marker);

        if (course == course) {
          onTapMarker(marker);
        }
      }
    } else {
      debugPrint("지도가 백그라운드 상태이므로 마커를 추가하지 않음");
    }
  }

  // 마커 탭 리스너
  void onTapMarker(NMarker marker) async {
    // 선택된 마커 설정
    selectCourseById(marker.info.id);
    selectMarker(marker);

    notifyListeners();
  }
}
