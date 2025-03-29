import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yeogijeogi/components/walk/walk_end_dialog.dart';

class WalkViewModel with ChangeNotifier {
  BuildContext context;

  WalkViewModel({required this.context});

  void onTapEnd() async {
    await showWalkEndDialog(
      context: context,
      onTapSave: context.pop,
      onTapCancel: context.pop,
    );
  }
}
