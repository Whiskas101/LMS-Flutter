import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';
import 'package:dy_integrated_5/screens/AttendanceScreen/SummaryGraph.dart';
import 'package:dy_integrated_5/screens/AttendanceScreen/SummaryTable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Graph Widget
            const SummaryGraph(),
            Consumer(
              builder: (context, ref, child) => ElevatedButton(
                  onPressed: () async {
                    // Todo, make this happen on setup and populate the Attendance Summary data model
                    var res = await ref
                        .read(apiServiceProvider)
                        .getAttendanceSummary();
                    print("frontend response: ${res.rawAttendanceData}");
                  },
                  child: const Text("fetch attendance data")),
            ),

            // Table breakdown widget
            const SummaryTable()
          ],
        ),
      ),
    );
  }
}
