import 'package:dy_integrated_5/screens/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/screens/New/AttendanceScreen.dart/AttendanceScreen.dart';
import 'package:dy_integrated_5/screens/New/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/screens/New/SettingsScreen/SettingsScreen.dart';
import 'package:dy_integrated_5/screens/New/VaultScreen/VaultScreen.dart';
import 'package:dy_integrated_5/widgets/AdaptiveScaffold.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final PageController _pageController = PageController();

  void _handlePageChanged(int index) {
    print("moving page: $index");
  }

  // Helper func
  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: _handlePageChanged,
      children: const <Widget>[
        DashboardV2(),
        AttendanceScreenV2(),
        VaultScreen(),
        SettingsScreen(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: SafeArea(
        child: buildPageView(),
      ),
    );
  }
}
