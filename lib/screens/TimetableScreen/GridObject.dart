import 'package:dy_integrated_5/providers/TimetableProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/TimeTable.dart';
import '../../utils/helpers.dart';


class GridObject extends ConsumerStatefulWidget {
  final String data;
  final String text;
  final int index;
  final int row;
  final int col;

  const GridObject({super.key, required this.data, required this.text, required this.index, required this.row, required this.col});

  @override
  ConsumerState<GridObject> createState() => _GridObjectState();
}

class _GridObjectState extends ConsumerState<GridObject> {

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


  @override
  Widget build(BuildContext context) {

    TimeTable data = ref.read(timetableNotifierProvider).value ?? TimeTable();
    String subjectName = data.timetable[widget.row][widget.col];
    bool hasSubjectData = data.timetable[widget.row][widget.col] != "";


    return GestureDetector(

      onTap: (){
         setState(() {
           ref.read(timetableNotifierProvider.notifier).setValue("", widget.row, widget.col);
         });
      },

      child: AnimatedScale(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubicEmphasized,
        scale: hasSubjectData ? 1.00 : 0.88,
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: hasSubjectData ? getSubjectColor(subjectName) : Colors.grey[50],
              border: Border.fromBorderSide(BorderSide(
                width: hasSubjectData ? 1 : 0,
                color: hasSubjectData ? Colors.grey : Colors.black26
              )),
              borderRadius: BorderRadius.circular(10)
          ),


          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Flexible(
                  flex:2,
                  child: Text(
                    hasSubjectData ? widget.text : timeAtIndex(widget.index),
                    style: TextStyle(color: hasSubjectData ? Colors.black87 : Colors.black26,
                      fontSize: hasSubjectData ? 10 : 9,
                      overflow: TextOverflow.clip
                    ),
                  ),
                ),
                hasSubjectData ? Flexible(
                  flex: 1,
                  child: Text(
                      timeAtIndex(widget.index),
                    style: const TextStyle(
                      fontSize: 8,

                    ),
                  ),
                ) : Container(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
