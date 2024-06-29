

import 'package:dy_integrated_5/models/Semester.dart';
import 'package:dy_integrated_5/services/api_service.dart';

// for State management
import 'package:riverpod/riverpod.dart';



class SemesterNotifier extends Notifier<Semester>{

  @override
  Semester build() {
    return Semester();
  }

  void getSemesterData({bool forceReFetch = false})async {
    Semester sem = await ApiService.getSemesterData(forceReFetch: forceReFetch);
    state = sem;
  }

}

final semesterNotifierProvider = NotifierProvider<SemesterNotifier, Semester>((){
  return SemesterNotifier();
});