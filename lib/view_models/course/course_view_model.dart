import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/models/course_model.dart';
import 'package:yeogijeogi/models/objects/course.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/constants.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class CourseViewModel with ChangeNotifier {
  final CourseModel courseModel;
  final BuildContext context;

  CourseViewModel({required this.courseModel, required this.context}) {
    isLoading = true;
    notifyListeners();

    // 모달 드래그 리스너 추가
    draggableController.addListener(_onDrag);
  }

  /// 네이버 지도 초기화 옵션
  NaverMapViewOptions options = NaverMapViewOptions(
    contentPadding: EdgeInsets.only(bottom: 173.h),
    initialCameraPosition: NCameraPosition(
      target: NLatLng(DEFAULT_LATITUDE, DEFAULT_LONGITUDE),
      zoom: 15,
    ),
  );

  late NaverMapController naverMapController;

  /// 메모 텍스트 컨트롤러
  TextEditingController controller = TextEditingController();

  /// 모달 시트 컨트롤러
  final DraggableScrollableController draggableController =
      DraggableScrollableController();

  /// 위치 버튼 활성화 여부
  bool isLocationActive = true;

  /// 모달 확장 여부 상태
  bool isExpanded = false;

  /// 로딩
  bool isLoading = false;

  /// 내 위치로 카메라 이동 (초기화)
  Future<void> moveToCurrentLocation() async {
    await naverMapController.setLocationTrackingMode(
      NLocationTrackingMode.follow,
    );

    isLocationActive = true;
    notifyListeners();
  }

  void onMapReady(NaverMapController controller) async {
    naverMapController = controller;

    await moveToCurrentLocation();

    // 코스 마커 추가
    for (Course course in courseModel.courses) {
      final NMarker marker = course.toNMarker();
      marker.setOnTapListener(onTapMarker);
      naverMapController.addOverlay(marker);
      courseModel.markers.add(marker);

      // 기본 선택된 코스의 경우 선택 처리
      if (course == courseModel.course) {
        onTapMarker(marker);
      }
    }

    isLoading = false;
    notifyListeners();
  }

  /// 카메라 움직일 때 호출되는 함수
  void onCameraChange(_, _) async {
    isLocationActive =
        await naverMapController.getLocationTrackingMode() ==
        NLocationTrackingMode.follow;
    notifyListeners();
  }

  // 마커 탭 리스너
  void onTapMarker(NMarker marker) async {
    // 선택된 마커 설정
    courseModel.selectCourseById(marker.info.id);
    courseModel.selectMarker(marker);

    notifyListeners();
  }

  // 드래그 이벤트 핸들러
  void _onDrag() {
    final isNowExpanded = draggableController.size >= 0.95;

    if (isNowExpanded != isExpanded) {
      if (isNowExpanded) {
        onExpanded();
      }

      isExpanded = isNowExpanded;
      notifyListeners();
    }
  }

  /// 앱바 뒤로가기 버튼
  void onTapBack() {
    draggableController.animateTo(
      0.228,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 모달 열렸을 때 상세 정보 가져오기
  void onExpanded() async {
    if (courseModel.course!.mood == null) {
      isLoading = true;
      notifyListeners();

      final detail = await API.getCourseDetail(walkId: courseModel.course!.id);
      await courseModel.course!.fromCourseDetailJson(detail);

      isLoading = false;
      notifyListeners();
    }
  }

  /// 코스 삭제
  void onTapDelete() {
    showCustomDialog(
      type: DialogType.deleteCourse,
      context: context,
      onTapAction: () async {
        isLoading = true;
        notifyListeners();

        naverMapController.deleteOverlay(courseModel.marker!.info);
        await courseModel.deleteSelectedCourse();

        draggableController.reset();

        isLoading = false;
        notifyListeners();

        if (context.mounted) context.pop();
      },
    );
  }

  @override
  void dispose() {
    draggableController.removeListener(_onDrag);
    draggableController.dispose();
    naverMapController.dispose();
    super.dispose();
  }
}
