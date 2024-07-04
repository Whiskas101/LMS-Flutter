

import '../utils/helpers.dart';

/// Generates a simple matrix of 5x8 by default, Five working days of the week, 8 hours of the day, 9am-5pm.
class TimeTable{

  late List<List<String>> timetable;

  TimeTable({int rows = 8, cols = 5}){
    List<List<String>> matrix = List.generate(
        rows, (i) => List.generate(
          cols, (j)=> ""
        )
    );

    timetable = matrix;
  }

  String valueAtIndex(int index){

    // print(index);
    int rowIndex = (index/5).floor();
    // if(rowIndex < 0 || rowIndex > 8) return "";
    int colIndex = index % 5;

    // print("${data.timetable[rowIndex][colIndex]} || ==> $rowIndex, $colIndex");
    if(timetable[rowIndex][colIndex] == ""){
      // print("empty at $rowIndex, $colIndex");
      return timeAtIndex(index);
    }else{
      // print("Not empty");
      return timetable[rowIndex][colIndex];
    }

  }

  void setValue(String value, int row, int col){
    print("setting $row $col to $value");
    timetable[row][col] = value;
  }


  TimeTable.fromMatrix(List<List<String>> matrixData){
    print("matrixdata $matrixData");
    timetable = matrixData;
  }



}