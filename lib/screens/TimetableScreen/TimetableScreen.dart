

import 'package:dy_integrated_5/screens/TimetableScreen/GridObject.dart';
import 'package:flutter/material.dart';



import '../../models/TimeTable.dart';


class AcceptState{
  Color color;
  String text;

  AcceptState({required this.color, required this.text});
}


class TimetableScreen extends StatefulWidget{



  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  @override
  Widget build(BuildContext context) {


    final data = TimeTable();
    // Generate a color coded version



    String dayAtIndex(int index){
      if (index < 0 || index > 4) return "-";
      final map = {
        0:'Mon',
        1:'Tue',
        2:'Wed',
        3:'Thu',
        4:'Fri'

      };
      return map[index]!;
    }

    String timeAtIndex(int index){
      int rowIndex = (index/5).floor();
      if(rowIndex < 0 || rowIndex > 8) return "";
      final map = {
        // Modulus of height of the matrix => current col num
        // Modulus of width of the matrix => current row num
        0:"9:00",
        1:"10:00",
        2:"11:00",
        3:"12:00",
        4:"1:00",
        5:"2:00",
        6:"3:00",
        7:"4:00",
      };
      return map[rowIndex]!;
    }

    String valueAtIndex(int index){
      // print(index);
      int rowIndex = (index/5).floor() % 5;
      // if(rowIndex < 0 || rowIndex > 8) return "";
      int colIndex = index % 5;

      print("${data.timetable[rowIndex][colIndex]} || ==> $rowIndex, $colIndex");
      if(data.timetable[rowIndex][colIndex] == ""){
        print("empty at $rowIndex, $colIndex");
        return timeAtIndex(index);
      }else{
        print("Not empty");
        return data.timetable[rowIndex][colIndex];
      }

    }

    List<String> subjects_temp = [
      "PCA",
      "EM",
      "AB",
      "SE",
      "EN"
    ];

    void setData(String newData, int row, int col){
      data.timetable[row][col] = newData;
    }


    final generatedSubjects = ["Break", "MP"];
    for (int i = 0; i < subjects_temp.length; i++ ){
      generatedSubjects.add(subjects_temp[i]);
      generatedSubjects.add("${subjects_temp[i]} LAB");
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25),
          child: Column(

            children: [
              // Title name
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(
                      "Your Timetable",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                      ),


                    ),
                  ),
                ],
              ),

              //Days of the week (working)
              Container(
                padding: EdgeInsets.all(8),
                height: 100,
                child: GridView.builder(

                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 2
                    ),
                    itemCount: data.timetable.length,


                    itemBuilder: (BuildContext context, int index) {

                      return Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10)
                        ),

                        child: Center(
                          child: Text(
                            dayAtIndex(index),
                            style: const TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      );
                    },

                ),
              ),

              //Time Table Matrix
              Container(
                height: 425,
                padding: const EdgeInsets.all(8),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,
                  
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: GridView.builder(

                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 2,

                    ),
                    itemCount: data.timetable.length * 8, // 8 refers to the max slots of 8 hours



                    itemBuilder: (BuildContext context, int index) {

                      final row = (index ~/5) % 5;
                      final col = index % 5;

                      return GestureDetector(
                        onTap: ()=>{print("I was tapped too")},
                        child: DragTarget<AcceptState>(

                          onAcceptWithDetails: (details){
                            data.timetable[(index/5).floor()%5][index % 5] = details.data.text;
                            print(data.timetable);
                          },
                          builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
                            print(data.timetable);
                            // NEED TO TEST WHETHER THE REBUILD IS MUTATING THE STATE OF THE TIMETABLE OR NOT!!!!!
                            return GridObject(
                                alterFunc: setData,
                                index:index,
                                data: data.timetable[row][col],
                                text: valueAtIndex(index), row: row, col: col,
                            );
                          },

                        ),
                      );
                    },

                  ),
                ),
              ),


              SizedBox(height: 15,),


              //Subjects to be dragged into timetable
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                height: 125,

                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    scrollDirection: Axis.horizontal,
                    itemCount: generatedSubjects.length,
                    itemBuilder: (context, index) {

                      return Draggable(
                        //Actual data that is being carried by the draggable object
                        data: AcceptState(text:generatedSubjects[index], color: Colors.greenAccent),

                        childWhenDragging: Container(

                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(10)
                          ),

                          child: Center(
                            child: Text(
                              generatedSubjects[index],
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black26
                              ),
                            ),
                          ),
                        ),

                        feedback: Container(

                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),

                          child: Container(
                            height: 50,
                            width: 50,

                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10)
                            ),

                            child: Center(
                              child: Text(
                                generatedSubjects[index],
                                style: TextStyle(
                                    color: Colors.black26,
                                  fontSize: 12,
                                  decoration: TextDecoration.none
                                ),
                              ),
                            ),
                          ),
                        ),

                        child: Container(

                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10)
                          ),

                          child: Center(
                            child: Text(
                              generatedSubjects[index],
                              style: const TextStyle(
                                fontSize: 12,
                                  color: Colors.black26
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                ),

              ),



            ],


          ),
        )


      ),
    );
  }
}
