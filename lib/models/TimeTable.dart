import '../utils/helpers.dart';

/// Generates a simple matrix of 5x8 by default, Five working days of the week, 8 hours of the day, 9am-5pm.
///

@Deprecated(
    "TimeTableV2 now handles timetable data, which is not a matrix anymore")
class TimeTable {
  late List<List<String>> timetable;

  TimeTable({int rows = 8, cols = 5}) {
    List<List<String>> matrix =
        List.generate(rows, (i) => List.generate(cols, (j) => ""));

    timetable = matrix;
  }

  String valueAtIndex(int index) {
    // print(index);
    int rowIndex = (index / 5).floor();
    // if(rowIndex < 0 || rowIndex > 8) return "";
    int colIndex = index % 5;

    // print("${data.timetable[rowIndex][colIndex]} || ==> $rowIndex, $colIndex");
    if (timetable[rowIndex][colIndex] == "") {
      // print("empty at $rowIndex, $colIndex");
      return timeAtIndex(index);
    } else {
      // print("Not empty");
      return timetable[rowIndex][colIndex];
    }
  }

  void setValue(String value, int row, int col) {
    print("setting $row $col to $value");
    timetable[row][col] = value;
  }

  TimeTable.fromMatrix(List<List<String>> matrixData) {
    print("matrixdata $matrixData");
    timetable = matrixData;
  }
}

class DaySchedule {
  late List<Map<String, String>> data;
}

Type day = Map<String, Map<String, List<Map<String, String>>>>;

class TimeTableV2 {
  // Map<String, dynamic> timetableData;
  late String stream;
  late String semesterDate;

  late Map<String, dynamic> mon;
  // late Map<String, dynamic> tue;
  // late Map<String, dynamic> wed;
  // late Map<String, dynamic> thu;
  // late Map<String, dynamic> fri;

  final week = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  ];

  TimeTableV2(Map<String, dynamic> jsonData) {
    // print(jsonData);
    // print(jsonData['Mon']);
    mon = jsonData['Mon'];
    // tue = jsonData['Tue'];
    // wed = jsonData['Wed'];
    // thu = jsonData['Thu'];
    // fri = jsonData['Fri'];

    stream = jsonData['class'];
    semesterDate = jsonData['semester'];
  }

  @override
  String toString() {
    return "TimeTableV2 Object\n  Stream: ${stream}\n  Semester: ${semesterDate}\n  Timetable: ${mon['data']}";
  }
}
