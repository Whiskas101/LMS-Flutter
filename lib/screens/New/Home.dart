import 'package:dy_integrated_5/providers/NavStateProvider.dart';
import 'package:dy_integrated_5/screens/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/screens/New/AttendanceScreen.dart/AttendanceScreen.dart';
import 'package:dy_integrated_5/screens/New/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/screens/New/SettingsScreen/SettingsScreen.dart';
import 'package:dy_integrated_5/screens/New/VaultScreen/VaultScreen.dart';
import 'package:dy_integrated_5/widgets/AdaptiveScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  Home({super.key});
  final PageController _pageController = PageController();

  void _handlePageChanged(int index) {
    print("moving page: $index");
  }

  void _test() {}

  // Helper func
  Widget buildPageView({WidgetRef? ref}) {
    return PageView(
      controller: _pageController,
      onPageChanged: (int value) {
        _handlePageChanged(value);

        // SYNC DETAIL
        // if the user swipes to move to the other screens instead of clicking
        // the bottom navigation bar items, update the provider state
        // so the bottom state is always in sync with the current screen.
        ref!.read(navStateProvider.notifier).setIndex(value);
      },
      children: const <Widget>[
        DashboardV2(),
        AttendanceScreenV2(),
        Dashboard(),
        VaultScreen(),
        SettingsScreen(),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentIndex = ref.watch(navStateProvider);
    print(":::$_currentIndex");
    return AdaptiveScaffold(
      pageViewController: _pageController,
      body: SafeArea(
        child: buildPageView(ref: ref),

        // For the bottom navigation bar
      ),
    );
  }
}
