import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../themes/themes.dart';

class ThemeNotifier extends AsyncNotifier<ThemeData> {
  // Just two themes for now ig
  ThemeData light = lightTheme;
  ThemeData dark = darkTheme;

  @override
  Future<ThemeData> build() async {
    // query the shared prefs to see if theres already something stored
    final prefs = await SharedPreferences.getInstance();
    final colorJson = prefs.get("seedColor");
    print('saved json color: $colorJson');
    // generate the theme and return if its found

    if (colorJson != null) {
      // create the color object
      final trueJson = jsonDecode(colorJson.toString());
      print("creating color object: $trueJson");

      Color seedColor = Color.from(
        alpha: trueJson['alpha'],
        red: trueJson['red'],
        green: trueJson['green'],
        blue: trueJson['blue'],
      );
      print('generating theme from seed: $seedColor');

      final generatedColorScheme = ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      );

      // early return;
      return ThemeData.from(
        colorScheme: generatedColorScheme,
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      );
    }

    return darkTheme;
  }

  void saveThemePref(Color seedColor) async {
    // TODO
    print("seedcolor: ${seedColor.toString()}");
    // parse all the values that represent the actual MaterialColor
    final alpha = seedColor.a;
    final red = seedColor.r;
    final blue = seedColor.b;
    final green = seedColor.g;

    final colorData = {
      'alpha': alpha,
      'red': red,
      'green': green,
      'blue': blue,
    };

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Updating theme with : $colorData");
    prefs.setString("seedColor", jsonEncode(colorData));
  }

  void setTheme(ThemeData data) {
    // just takes a theme and sets it like a chad would
    state = AsyncValue.data(data);
  }

  // do not use this, it is cancerous
  // void toggleTheme() {
  //   if (state == light) {
  //     state = dark;
  //   } else {
  //     state = light;
  //   }
  // }
}

final themeNotifierProvider =
    AsyncNotifierProvider<ThemeNotifier, ThemeData>(() => ThemeNotifier());
