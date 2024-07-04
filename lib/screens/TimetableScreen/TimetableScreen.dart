

import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/providers/TimetableProvider.dart';
import 'package:dy_integrated_5/screens/TimetableScreen/DaysHeader.dart';
import 'package:dy_integrated_5/screens/TimetableScreen/DraggableSubjectsGrid.dart';
import 'package:dy_integrated_5/screens/TimetableScreen/GridObject.dart';
import 'package:dy_integrated_5/screens/TimetableScreen/ScreenTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../models/TimeTable.dart';




class TimetableScreen extends ConsumerWidget{

  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    print("rebuilt");
    final data = ref.watch(timetableNotifierProvider);

    final semester = ref.watch(semesterNotifierProvider);


    List<String> subjects_temp = [
      "PCA",
      "EM",
      "AB",
      "SE",
      "EN"
    ];

    void setData(String newData, int row, int col){
      // data.timetable[row][col] = newData;
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
              const ScreenTitle(),

              //Days of the week (working)
              const DaysHeader(),

              //Time Table Matrix
              Expanded(
                child: data.when(
                    data: (data){
                      return Container(

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
                            itemCount: data.timetable.length * 5, // 5 refers to no. of working days
                
                
                
                            itemBuilder: (BuildContext context, int index) {
                
                              final row = (index ~/5);
                              final col = index % 5;
                
                              return DragTarget<AcceptState>(
                                onAcceptWithDetails: (dragDetails){
                                  print("Accepted");
                                  ref.read(timetableNotifierProvider.notifier).setValue(dragDetails.data.text, row, col);
                                },
                                builder: (context, candidateData, rejectedData) =>
                                    GridObject(
                                  index:index,
                                  data: data.timetable[row][col],
                                  text: data.valueAtIndex(index), row: row, col: col,
                                ),
                              );
                            },
                
                          ),
                        ),
                      );
                
                    },
                    error: (error, stackTrace)=>Text(error.toString()),
                    loading: ()=>const CircularProgressIndicator()
                ),
              ),


              const SizedBox(height: 15,),


              //Subjects to be dragged into timetable
              semester.when(
                  data: (semester)=>DraggableSubjectsGrid(semester: semester,),
                  error: (error, stackTrace)=>const Text("Something went wrong"),
                  loading: ()=> const CircularProgressIndicator()
              )



            ],


          ),
        )


      ),
    );
  }
}
