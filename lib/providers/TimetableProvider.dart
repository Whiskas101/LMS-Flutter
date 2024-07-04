import 'dart:async';
import 'dart:convert';



import 'package:dy_integrated_5/models/TimeTable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';



class TimetableNotifier extends AsyncNotifier<TimeTable>{
  late TimeTable _timetable;

  @override
  Future<TimeTable> build() async {

    print("TimetableNotifer built");

    final storage = await SharedPreferences.getInstance();
    String? rawTimetableData = storage.getString("timetable");
    print(rawTimetableData);
    print(storage);
    if (rawTimetableData == null){
      print("Shared Prefs did NOT have a timetable stored");
      _timetable = TimeTable();
      return _timetable;
    }
    print("Found timetable stored");

    List<dynamic> jsonResponse = jsonDecode(rawTimetableData);
    List<List<String>> matrix = jsonResponse.map((list) => List<String>.from(list)).toList();
    _timetable = TimeTable.fromMatrix(matrix);

    return _timetable;
  }

  void getTimeTable() async {
    print("Manual fetch requested");
    state = const AsyncLoading();
    final storage = await SharedPreferences.getInstance();
    String? rawTimetableData = storage.getString("timetable");
    if (rawTimetableData == null){
      print("Shared Prefs did NOT have a timetable stored");
      _timetable = TimeTable();
      state = AsyncData(_timetable);
    }

    List<dynamic> jsonResponse = jsonDecode(rawTimetableData!);
    List<List<String>> matrix = jsonResponse.map((list) => List<String>.from(list)).toList();
    _timetable = TimeTable.fromMatrix(matrix);
    state = AsyncData(_timetable);


  }

  void setValue(String value, int row, int col){
    state = const AsyncLoading();
    _timetable.setValue(value, row, col);
    print(_timetable.timetable);
    state = AsyncData(_timetable);
    // state = AsyncData<TimeTable>(_timetable);
  }

  Future<bool> save() async {
    SharedPreferences _storage = await SharedPreferences.getInstance();
    return await _storage.setString("timetable", jsonEncode(_timetable.timetable));
  }


}


final timetableNotifierProvider = AsyncNotifierProvider<TimetableNotifier, TimeTable>(
    ()=>TimetableNotifier()
);

