import 'package:dy_integrated_5/widgets/AdaptiveScaffold.dart';
import 'package:flutter/material.dart';

class AttendanceScreenV2 extends StatelessWidget {
  const AttendanceScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ATNDC Text, with description
        Flexible(
          flex: 3,
          child: Container(
            color: Colors.red,
          ),
        ),

        // summary section
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.blue,
          ),
        ),

        // Breakdown section? idk what's the difference
        Flexible(
          flex: 6,
          child: Container(
            color: Colors.green,
          ),
        )
      ],
    );
  }
}
