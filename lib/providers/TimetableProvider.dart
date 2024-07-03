import 'dart:async';
import 'dart:convert';


import 'package:dy_integrated_5/models/TimeTable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';



class TimetableNotifier extends AsyncNotifier<TimeTable>{
  @override
  Future<TimeTable> build() async {
    final storage = await SharedPreferences.getInstance();
    String rawTimetableData = storage.getString("timetable")!;
    if (rawTimetableData.isEmpty){
      return TimeTable();
    }
    TimeTable timetableMatrix = jsonDecode(rawTimetableData);
    return timetableMatrix;
  }
}


final timetableNotifierProvider = AsyncNotifierProvider<TimetableNotifier, TimeTable>(
    ()=>TimetableNotifier()
);

