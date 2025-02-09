import 'package:dy_integrated_5/providers/ThemeProvider.dart';
import 'package:dy_integrated_5/screens/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/screens/ThemeScreen/ThemeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // The actual display of the stuff
            Flexible(
              flex: 7,
              child: Transform.scale(
                scale: 0.70,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: const Color.fromARGB(255, 255, 42, 26),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(200),
                        blurRadius: 1000,
                        spreadRadius: -100,
                        // offset: const Offset(0, 205),
                      )
                    ],
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 8,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const IgnorePointer(
                      ignoring: true,
                      child: Dashboard(),
                      // child: SizedBox(
                      //   height: 100,
                      //   width: 200,
                      // ),
                    ),
                  ),
                ),
              ),
            ),

            // The theme choice section
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ThemeButton(
                      themeName: "",
                      seedColor: Colors.red,
                    ),
                    ThemeButton(
                      themeName: "",
                      seedColor: const Color.fromARGB(255, 255, 238, 0),
                    ),
                    ThemeButton(
                      themeName: "",
                      seedColor: const Color.fromARGB(255, 255, 4, 251),
                    ),
                    ThemeButton(
                      themeName: "",
                      seedColor: const Color.fromARGB(255, 4, 255, 33),
                    ),
                    ThemeButton(
                      themeName: "",
                      seedColor: const Color.fromARGB(255, 0, 229, 255),
                    ),
                    ThemeButton(
                      themeName: "",
                      seedColor: const Color.fromARGB(255, 255, 4, 4),
                    ),
                    ThemeButton(
                      themeName: "",
                      seedColor: const Color.fromARGB(255, 4, 4, 255),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
