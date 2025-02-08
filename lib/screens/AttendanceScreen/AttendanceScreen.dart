import 'package:dy_integrated_5/models/Attendance.dart';
import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';
import 'package:dy_integrated_5/screens/AttendanceScreen/SummaryGraph.dart';
import 'package:dy_integrated_5/screens/AttendanceScreen/SummaryTable.dart';

import 'package:dy_integrated_5/providers/AttendanceProvider.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
