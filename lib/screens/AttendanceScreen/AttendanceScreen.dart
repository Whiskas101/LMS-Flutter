import 'package:dy_integrated_5/screens/AttendanceScreen/SummaryGraph.dart';
import 'package:dy_integrated_5/screens/AttendanceScreen/SummaryTable.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Graph Widget
            SummaryGraph(),

            // Table breakdown widget
            SummaryTable()
          ],
        ),
      ),
    );
  }
}
