

import 'package:dy_integrated_5/models/Semester.dart';
import 'package:dy_integrated_5/services/api_service.dart';

// for State management
import 'package:flutter_riverpod/flutter_riverpod.dart';



class SemesterNotifier extends AsyncNotifier<Semester>{

  @override
  Future<Semester> build() async {
    return await ApiService.getSemesterData();
  }

  void getSemesterData({bool forceReFetch = false})async {
    state = const AsyncLoading<Semester>();
    Semester sem = await ApiService.getSemesterData(forceReFetch: forceReFetch);
    print(sem);
    state = AsyncData(sem);
  }

}

final semesterNotifierProvider = AsyncNotifierProvider<SemesterNotifier, Semester>((){
  return SemesterNotifier();
});