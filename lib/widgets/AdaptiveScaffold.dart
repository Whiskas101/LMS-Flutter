// a teeny abstraction over [Scaffold] that handles the bottom navigation bar or rail based on layout etc

// Wrapping stuff

import 'package:flutter/material.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget body;
  const AdaptiveScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Check constraints of viewport
        double width = MediaQuery.of(context).size.width;
        bool isWideScreen = width > 600;
        print("Widescreen status : $isWideScreen");
        return Scaffold(
          body: body,
          bottomNavigationBar: isWideScreen == false
              ? BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      label: "temp",
                      icon: Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "temp",
                      icon: Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "temp",
                      icon: Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "temp",
                      icon: Icon(
                        Icons.place,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                )
              : null,
        );
      },
    );
  }
}
