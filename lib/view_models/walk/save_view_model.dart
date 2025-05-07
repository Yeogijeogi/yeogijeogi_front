import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/models/course_model.dart';
import 'package:yeogijeogi/models/objects/coordinate.dart';
import 'package:yeogijeogi/models/objects/course.dart';
import 'package:yeogijeogi/models/walk_model.dart';
import 'package:yeogijeogi/utils/api.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class SaveViewModel with ChangeNotifier {
  CourseModel courseModel;
  WalkModel walkModel;
  BuildContext context;

  SaveViewModel({
    required this.walkModel,
    required this.context,
    required this.courseModel,
  });

  /// 분위기 슬라이더 값
  double moodLevel = 0;

  /// 산책 슬라이더 값
  double difficultyLevel = 0;

  /// 메모 Text Controller
  TextEditingController controller = TextEditingController();

  /// 로딩
  bool isLoading = false;

  /// 분위기 슬라이더 값 업데이트
  void updateSceneryLevel(double value) {
    moodLevel = value;
    notifyListeners();
  }

  /// 산책 슬라이더 값 업데이트
  void updateWalkingLevel(double value) {
    difficultyLevel = value;
    notifyListeners();
  }

  /// 메모 입력 6줄 제한
  TextEditingValue limitLines(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    int newLines = newValue.text.split('\n').length;
    if (newLines > 6) {
      return oldValue;
    } else {
      return newValue;
    }
  }

  /// 이미지 firebase 업로드
  Future<String> uploadImageToFirebase() async {
    try {
      debugPrint('Uploading image to firebase');

      final Reference storage = FirebaseStorage.instance.ref(
        'images/${walkModel.id}.png',
      );

      if (walkModel.image != null) {
        await storage.putFile(walkModel.image!);
        debugPrint('Upload complete');

        return await storage.getDownloadURL();
      } else {
        debugPrint('Failed to upload image to firebase: Image not found');
        throw Error();
      }
    } catch (e) {
      debugPrint('Error uploading image to firebase');
      throw Error();
    }
  }

  /// 저장
  void onTapSave() async {
    isLoading = true;
    notifyListeners();

    // 이미지 firebase 업로드
    final String imageUrl = await uploadImageToFirebase();

    // 완료 api 호출
    await API.patchWalkEnd(
      walkModel.id!,
      moodLevel.toInt(),
      difficultyLevel.toInt(),
      controller.text.trim(),
    );

    courseModel.courses.add(
      Course(
        id: walkModel.id!,
        location: Coordinate.fromNLatLng(walkModel.pathList.last),
        name: walkModel.endName!,
        address: walkModel.endName!,
        distance: walkModel.summary!.distance,
        time: walkModel.summary!.time,
        speed: walkModel.summary!.speed,
        imgUrl: imageUrl,
        mood: moodLevel.toDouble(),
        difficulty: difficultyLevel.toDouble(),
        memo: controller.text.trim(),
      ),
    );
    isLoading = false;

    courseModel.selectCourseById(walkModel.id!);
    courseModel.drawMarkers();
    notifyListeners();

    if (context.mounted) context.goNamed(AppRoute.course.name);

    // 모델 리셋
    walkModel.reset();
  }
}
