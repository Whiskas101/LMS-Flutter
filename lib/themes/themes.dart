import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// To be implemented soon.

//Light Theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color(0xFF6FDBA8),
  ),
  useMaterial3: true,
  textTheme: GoogleFonts.aBeeZeeTextTheme(),
);

//Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
      seedColor: Color.fromARGB(255, 55, 143, 149),
      primary: Color.fromARGB(255, 96, 249, 167),
      // seedColor: Color.fromARGB(255, 111, 151, 219),
      brightness: Brightness.dark),
  useMaterial3: true,
  textTheme: GoogleFonts.aBeeZeeTextTheme(),
);
