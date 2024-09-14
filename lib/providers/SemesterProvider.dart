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
    // this var is to make it easier to animate a visual indication when the refresh is taking place

    // Keep the current (stale) data there, so user doesn't lose interactivity when the connection is slow or fetch takes a long time
    state = const AsyncLoading<Semester>().copyWithPrevious(state);

    final apiService = ref.read(apiServiceProvider);
    Semester sem = await apiService.getSemesterData(forceReFetch: forceReFetch);
    // print(sem);
    state = AsyncData(sem);
  }
}

final semesterNotifierProvider =
    AsyncNotifierProvider<SemesterNotifier, Semester>(() {
  return SemesterNotifier();
});
