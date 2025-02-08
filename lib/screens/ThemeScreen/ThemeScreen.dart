import 'package:dy_integrated_5/screens/Dashboard/Dashboard.dart';
import 'package:flutter/material.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // The actual display of the stuff
            Transform.scale(
              scale: 0.40,
              child: Container(
                height: 800,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 255, 42, 26),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(200),
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

            // The theme choice section
            // Icon(Icons.change_circle),
          ],
        ),
      ),
    );
  }
}
