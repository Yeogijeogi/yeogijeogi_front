import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/walk/course_detail.dart';
import 'package:yeogijeogi/main.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/course/course_detail_view_model.dart';
import 'package:yeogijeogi/view_models/course/course_view_model.dart';
import 'package:yeogijeogi/views/course/course_detail_view.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  final DraggableScrollableController _draggableController =
      DraggableScrollableController();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _draggableController.addListener(_onDrag);
  }

  void _onDrag() {
    // 확장 상태 판단 기준 (1.0에 가까우면 확장된 것으로 판단)
    final isNowExpanded = _draggableController.size >= 0.95;
    if (isNowExpanded != _isExpanded) {
      setState(() {
        _isExpanded = isNowExpanded;
      });
    }
  }

  @override
  void dispose() {
    _draggableController.removeListener(_onDrag);
    _draggableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseViewModel = context.watch<CourseViewModel>();

    return CustomScaffold(
      useSafeArea: false,
      hasPadding: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const NaverMap(),
          DraggableScrollableSheet(
            controller: _draggableController,
            maxChildSize: 1.0,
            initialChildSize: 0.204,
            minChildSize: 0.204,
            expand: false,
            snap: true,
            snapSizes: const [0.204, 1.0],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Palette.surface,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  children: [
                    // 핸들
                    Container(
                      width: 40.w,
                      height: 4.h,
                      margin: EdgeInsets.only(top: 16.h, bottom: 20.h),
                      decoration: BoxDecoration(
                        color: Palette.onSurfaceVariant,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),

                    // 내용 영역
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 20.h,
                              left: 20.w,
                              right: 20.w,
                            ),
                            child:
                                _isExpanded
                                    ? ChangeNotifierProvider(
                                      create:
                                          (_) => CourseDetailViewModel(
                                            courseModel:
                                                courseViewModel.courseModel,
                                            context: context,
                                            draggableController:
                                                _draggableController,
                                          ),
                                      child: const CourseDetailView(),
                                    )
                                    : Align(
                                      alignment: Alignment.topCenter,
                                      child: CourseDetail(
                                        name: '성북천',
                                        address: '서울 성북구 동선동2가',
                                        distance: 1.3,
                                        distanceLabel: '이동 거리',
                                        walk: '3km/h',
                                        walkLabel: '평균 속도',
                                        time: 24,
                                        timeLabel: '소요 시간',
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
