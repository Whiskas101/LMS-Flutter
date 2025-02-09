import 'package:dy_integrated_5/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// A class to represent the theme that could be
class ThemeButton extends ConsumerWidget {
  final seedColor;
  final themeName;
  final themeData;

  ThemeButton({super.key, required this.seedColor, required this.themeName})
      : themeData = ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: seedColor,
            brightness: Brightness.dark,
          ),
          textTheme: GoogleFonts.aBeeZeeTextTheme(),
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _colors = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );

    return GestureDetector(
      onTap: () {
        // set the theme on tap
        ref.read(themeNotifierProvider.notifier).saveThemePref();
        ref.read(themeNotifierProvider.notifier).setTheme(themeData);
      },
      child: Stack(children: [
        // Background
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: _colors.primary,
                  blurRadius: 25,
                  spreadRadius: -6,
                  blurStyle: BlurStyle.outer,
                ),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CustomPaint(
              painter: WavePainter(
                primary: _colors.primary,
                secondary: _colors.secondary,
                tertiary: _colors.tertiary,
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  themeName,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ),
          ),
        ),

        // Text
      ]),
    );
  }
}

class WavePainter extends CustomPainter {
  final Color primary;
  final Color secondary;
  final Color tertiary;

  WavePainter(
      {required this.primary, required this.secondary, required this.tertiary});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    paint.color = secondary;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    Path wavePath1 = Path();
    wavePath1.moveTo(0, 0);
    wavePath1.quadraticBezierTo(size.width * 0.25, size.height * 0.8,
        size.width * 0.5, size.height * 0.7);
    wavePath1.quadraticBezierTo(
        size.width * 0.75, size.height * 0.6, size.width, size.height * 0.7);
    wavePath1.lineTo(size.width, size.height);
    wavePath1.lineTo(0, size.height);
    wavePath1.close();

    paint.color = primary;
    canvas.drawPath(wavePath1, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
