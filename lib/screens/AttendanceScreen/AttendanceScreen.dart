import 'package:dy_integrated_5/models/Attendance.dart';
import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';
import 'package:dy_integrated_5/providers/SemesterProvider.dart';

import 'package:dy_integrated_5/providers/AttendanceProvider.dart';
import 'package:dy_integrated_5/widgets/BigSubjectWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  void fetchAttendanceData(WidgetRef ref) async {
    // Todo, make this happen on setup and populate the Attendance Summary data model
    var res = await ref.read(apiServiceProvider).getAttendanceSummary();
    print("frontend response: ${res.rawAttendanceData}");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final semester = ref.watch(semesterNotifierProvider);
    final attendanceSummary = ref.watch(attendanceSummaryNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top section, the title
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Row(
                spacing: 10,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.exit_to_app,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  // Top text
                  Text(
                    "Attendance",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 1.3,
                    ),
                  )
                ],
              ),
            ),

            // List of subjects, with the data
            Expanded(
              child: attendanceSummary.when(
                data: (summary) {
                  return ListView.builder(
                    itemCount: summary.rawAttendanceData.length,
                    // shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BigSubjectWidget(
                          attendanceData: summary.rawAttendanceData[index],
                        ),
                      );
                    },
                  );
                },
                error: (err, trace) => Text("Error!"),
                loading: () => Text("Loading..."),
              ),
            )
          ],
        ),
      ),
    );
  }
}
