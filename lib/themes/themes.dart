import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// To be implemented soon.

//Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Color.fromARGB(255, 219, 255, 12),
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.aBeeZeeTextTheme(),
);

//Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(209, 145, 3, 246),
    // primary: Color.fromARGB(255, 0, 252, 117),

    // primary: Colors.white,
    // secondary: Color(0xFFDDECF9),

    // seedColor: Color.fromARGB(255, 111, 151, 219),
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.aBeeZeeTextTheme(),
  // textTheme: GoogleFonts.aBeeZeeTextTheme(),
);
