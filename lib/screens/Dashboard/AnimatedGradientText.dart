import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;
  final List<Color>? colors;
  final double radius;

  const AnimatedGradientText({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(seconds: 1),
    required this.colors,
    required this.radius,
  });

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _alignmentAnimation;
  late List<Color> _defaultColors;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    // _colorAnimation =
    //     ColorTween(begin: widget.colors[0], end: widget.colors.last)
    //         .animate(_controller);

    _alignmentAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInExpo);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // if no widget.colors was specified, fallback on the default colors
    _defaultColors = widget.colors ??
        [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ];

    _colorAnimation =
        ColorTween(begin: _defaultColors[0], end: _defaultColors.last)
            .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // mafs to make it smooth and repetitive
        double x = _alignmentAnimation.value;
        double y = sin(_alignmentAnimation.value);

        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return RadialGradient(
              // begin: _alignmentAnimation.value,
              // focal: _alignmentAnimation.value,
              colors: [
                _colorAnimation.value ?? _defaultColors[0],
                _defaultColors[1],
                _colorAnimation.value ?? _defaultColors[2],
              ],
              radius: widget.radius,
              center: Alignment(x, y),
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: widget.style,
          ),
        );
      },
    );
  }
}
