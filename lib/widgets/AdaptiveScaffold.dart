// a teeny abstraction over [Scaffold] that handles the bottom navigation bar or rail based on layout etc

// Wrapping stuff

import 'package:dy_integrated_5/providers/NavStateProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget body;
  final PageController pageViewController;
  const AdaptiveScaffold({
    super.key,
    required this.body,
    required this.pageViewController,
  });

  // Use a riverpod provider to handle currently selected state

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Check constraints of viewport
        double width = MediaQuery.of(context).size.width;
        bool isWideScreen = width > 600;
        print("Widescreen status : $isWideScreen");
        // TODO: Add a navigation rail for desktop by checking the isWideScreen

        return Scaffold(
          // backgroundColor: Colors.red,
          body: body,
          bottomNavigationBar: isWideScreen == false
              ? Consumer(builder: (context, ref, child) {
                  final selectedIndex = ref.watch(navStateProvider);
                  return BottomNavigationBar(
                    onTap: (value) {
                      print("Navigation tapped: $value");
                      pageViewController.animateToPage(
                        value,
                        duration: const Duration(seconds: 1),
                        curve:
                            Curves.easeInOutCubicEmphasized, // I like this one
                      );
                      // Update the state so the visual representation of the nav
                      // bar updates too
                      ref.read(navStateProvider.notifier).setIndex(value);
                    },
                    backgroundColor: Colors.transparent,
                    currentIndex: selectedIndex,
                    showSelectedLabels: false, // do not show label text
                    showUnselectedLabels: false,
                    items: const <BottomNavigationBarItem>[
                      // TODO: update icons, figure out logic for varying colors when selected

                      // Dashboard
                      BottomNavigationBarItem(
                        label: "Dashboard",
                        activeIcon: Icon(
                          Icons.dashboard_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        icon: Icon(
                          Icons.dashboard_rounded,
                          color: Color(0xff5A5969),
                          size: 40,
                        ),
                      ),

                      // Attendance
                      BottomNavigationBarItem(
                        label: "Attendance",
                        activeIcon: Icon(
                          Icons.calendar_month_rounded,
                          color: Color(0xffE7F98B),
                          size: 40,
                        ),
                        icon: Icon(
                          Icons.calendar_month_rounded,
                          color: Color(0xff5A5969),
                          size: 40,
                        ),
                      ),

                      // Vault
                      BottomNavigationBarItem(
                        label: "Vault",
                        activeIcon: Icon(
                          Icons.add_box_rounded,
                          color: Color(0xff21D398),
                          size: 40,
                        ),
                        icon: Icon(
                          Icons.add_box_rounded,
                          color: Color(0xff5A5969),
                          size: 40,
                        ),
                      ),

                      // Settings or Config
                      BottomNavigationBarItem(
                        label: "Config",
                        activeIcon: Icon(
                          Icons.settings,
                          color: Color(0xff15A3F0),
                          size: 40,
                        ),
                        icon: Icon(
                          Icons.settings,
                          // color: Colors.red,
                          color: Color(0xff5A5969),
                          size: 40,
                        ),
                      ),
                    ],
                  );
                })
              : null,
        );
      },
    );
  }
}
