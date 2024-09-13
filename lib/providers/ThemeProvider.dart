import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../themes/themes.dart';

// To be removed!//

class ThemeNotifier extends Notifier<ThemeData> {
  // Just two themes for now ig
  ThemeData light = lightTheme;
  ThemeData dark = darkTheme;

  @override
  ThemeData build() {
    return light;
  }

  void toggleTheme() {
    if (state == light) {
      state = dark;
    } else {
      state = light;
    }
  }
}

final themeNotifierProvider =
    NotifierProvider<ThemeNotifier, ThemeData>(() => ThemeNotifier());
