import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LimitWidth extends StatelessWidget {
  final Widget child;

  const LimitWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = 0.75 * constraints.maxWidth;

      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: (defaultTargetPlatform == TargetPlatform.macOS ||
                    defaultTargetPlatform == TargetPlatform.windows ||
                    defaultTargetPlatform == TargetPlatform.linux)
                ? maxWidth
                : double.infinity,
          ),
          child: child,
        ),
      );
    });
  }
}
