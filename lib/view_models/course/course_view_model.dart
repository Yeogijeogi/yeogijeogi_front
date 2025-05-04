import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/common/custom_dialog.dart';
import 'package:yeogijeogi/models/course_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/constants.dart';
import 'package:yeogijeogi/utils/enums/dialog_type.dart';

class CourseViewModel with ChangeNotifier {
  final CourseModel courseModel;
  final BuildContext context;

  CourseViewModel({required this.courseModel, required this.context}) {
    // 모달 드래그 리스너 추가
    draggableController.addListener(_onDrag);

    // courseModel 변경 감지
    courseModel.addListener(_onCourseModelChanged);
  }

  void _onCourseModelChanged() {
    notifyListeners();
  }

  /// 네이버 지도 초기화 옵션
  NaverMapViewOptions options = NaverMapViewOptions(
    contentPadding: EdgeInsets.only(bottom: 173.h),
    initialCameraPosition: NCameraPosition(
      target: NLatLng(DEFAULT_LATITUDE, DEFAULT_LONGITUDE),
      zoom: 15,
    ),
  );

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
  bool isLoading = true;

  /// 내 위치로 카메라 이동 (초기화)
  Future<void> moveToCurrentLocation() async {
    await courseModel.naverMapController?.setLocationTrackingMode(
      NLocationTrackingMode.follow,
    );

    isLocationActive = true;
    notifyListeners();
  }

  void onMapReady(NaverMapController controller) async {
    courseModel.naverMapController = controller;

    await moveToCurrentLocation();

    // 코스 마커 추가
    courseModel.drawMarkers();

    isLoading = false;
    notifyListeners();
  }

  /// 카메라 움직일 때 호출되는 함수
  void onCameraChange(_, _) async {
    isLocationActive =
        await courseModel.naverMapController?.getLocationTrackingMode() ==
        NLocationTrackingMode.follow;
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
    if (courseModel.course?.mood == null) {
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

        courseModel.naverMapController?.deleteOverlay(courseModel.marker!.info);
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
    courseModel.naverMapController?.dispose();
    super.dispose();
  }
}
