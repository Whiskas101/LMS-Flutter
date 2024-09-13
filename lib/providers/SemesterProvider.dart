import 'package:dy_integrated_5/models/Semester.dart';
import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';

// for State management
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SemesterNotifier extends AsyncNotifier<Semester> {
  @override
  Future<Semester> build() async {
    final apiService = ref.read(apiServiceProvider);
    return await apiService.getSemesterData();
  }

  void getSemesterData({bool forceReFetch = false}) async {
    state = const AsyncLoading<Semester>();
    final apiService = ref.read(apiServiceProvider);
    Semester sem = await apiService.getSemesterData(forceReFetch: forceReFetch);
    print(sem);
    state = AsyncData(sem);
  }
}

final semesterNotifierProvider =
    AsyncNotifierProvider<SemesterNotifier, Semester>(() {
  return SemesterNotifier();
});
