import 'package:flutter/material.dart';


class GridObject extends StatefulWidget {
  String data;
  late String text;

  final int index;

  late int row;
  late int col;
  late void Function(String newData, int row, int col) alterFunc;

  GridObject({super.key, required this.data, required this.text, required this.index, required this.alterFunc, required this.row, required this.col});

  @override
  State<GridObject> createState() => _GridObjectState();
}

class _GridObjectState extends State<GridObject> {

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
    print("Widget rebuilt with data: ${widget.data}, ${widget.text}");
    return GestureDetector(

      onTap: (){
        setState(() {
          widget.data = "";
          widget.alterFunc("", widget.row, widget.col);
          widget.text = timeAtIndex(widget.index);
        });
      },

      child: AnimatedScale(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubicEmphasized,
        scale: widget.data.isNotEmpty ? 1.00 : 0.88,
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: widget.data.isNotEmpty ? Colors.lightBlueAccent : Colors.grey,
              border: Border.fromBorderSide(BorderSide(
                width: widget.data.isNotEmpty ? 1 : 0,
                color: widget.data.isNotEmpty ? Colors.grey : Colors.black26
              )),
              borderRadius: BorderRadius.circular(10)
          ),


          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                      color: widget.data.isNotEmpty ? Colors.blueGrey : Colors.black26
                  ),


                ),

                widget.data.isNotEmpty ? Text(
                    timeAtIndex(widget.index),
                  style: TextStyle(
                    fontSize: 8
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
