import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/components/walk/course_detail.dart';
import 'package:yeogijeogi/utils/palette.dart';
import 'package:yeogijeogi/view_models/course/course_detail_view_model.dart';
import 'package:yeogijeogi/view_models/course/course_view_model.dart';
import 'package:yeogijeogi/views/course/course_detail_view.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  _CourseViewState createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  @override
  Widget build(BuildContext context) {
    final courseViewModel = context.watch<CourseViewModel>();

    return CustomScaffold(
      useSafeArea: false,
      hasPadding: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NaverMap(),
          GestureDetector(
            onVerticalDragUpdate: (details) {
              courseViewModel.updateSheetHeight(details.primaryDelta!);
            },
            onTap: () {
              courseViewModel.toggleSheet();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height:
                  MediaQuery.of(context).size.height *
                  courseViewModel.sheetHeight,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 16.h,
                left: 20.w,
                right: 20.w,
                bottom: 20.h,
              ),
              decoration: BoxDecoration(
                color: Palette.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                boxShadow: [
                  BoxShadow(
                    color: Palette.onSurfaceVariant.withAlpha(25),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 20.h),
                    decoration: BoxDecoration(
                      color: Palette.onSurfaceVariant,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child:
                          // 최대로 올라가면 상세 화면
                          courseViewModel.isExpanded
                              ? ChangeNotifierProvider(
                                create:
                                    (_) =>
                                        CourseDetailViewModel(context: context),
                                child: const CourseDetailView(),
                              )
                              : CourseDetail(
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
          ),
        ],
      ),
    );
  }
}
