import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeogijeogi/components/common/custom_scaffold.dart';
import 'package:yeogijeogi/view_models/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = context.watch<HomeViewModel>();

    return CustomScaffold(
      isLoading: homeViewModel.isLoading,
      body: Center(
        child: FilledButton(
          onPressed: homeViewModel.logout,
          child: Text('로그아웃'),
        ),
      ),
    );
  }
}
