import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/walk/walk_end_dialog.dart';
import 'package:yeogijeogi/utils/enums/app_routes.dart';

class WalkViewModel with ChangeNotifier {
  BuildContext context;

  WalkViewModel({required this.context});

  void onTapEnd() async {
    await showWalkEndDialog(
      context: context,
      onTapSave: save,
      onTapCancel: context.pop,
    );
  }

  void save() {
    context.goNamed(AppRoute.save.name);
  }
}
