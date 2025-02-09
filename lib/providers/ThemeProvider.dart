import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/themes.dart';

class ThemeNotifier extends Notifier<ThemeData> {
  // Just two themes for now ig
  ThemeData light = lightTheme;
  ThemeData dark = darkTheme;

  @override
  ThemeData build() {
    return darkTheme;
  }

  void saveThemePref() async {
    // TODO
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const colors = Colors.red;
    prefs.setString("seedColor", colors.toString());
  }

  void setTheme(ThemeData data) {
    // just takes a theme and sets it like a chad would
    state = data;
  }

  // do not use this, it is cancerous
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
