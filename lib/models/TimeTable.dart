

/// Generates a simple matrix of 5x8
class TimeTable{

  late List<List<String>> timetable;

  TimeTable({int rows = 5, cols = 8}){
    List<List<String>> matrix = List.generate(
        rows, (i) => List.generate(
          cols, (j)=> ""
        )
    );

    timetable = matrix;
  }


  TimeTable.fromMatrix(List<List<String>> matrixData){
    timetable = matrixData;
  }



}