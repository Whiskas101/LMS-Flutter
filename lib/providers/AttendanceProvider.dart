import 'package:dy_integrated_5/models/Attendance.dart';
import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';

// for State management
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceSummaryNotifier extends AsyncNotifier<AttendanceSummary> {
  // attendance summary is a function of courses and attendance data

  @override
  Future<AttendanceSummary> build() async {
    print("AttendanceSummary build started");
    final apiService = ref.read(apiServiceProvider);

    AttendanceSummary result = await apiService.getAttendanceSummary();
    print('Att summary: build: ${result}');
    return result;
  }
}

final attendanceSummaryNotifierProvider =
    AsyncNotifierProvider<AttendanceSummaryNotifier, AttendanceSummary>(() {
  return AttendanceSummaryNotifier();
});
