import 'package:flutter/material.dart';


class GridObject extends StatefulWidget {
  String data;
  String text;


  GridObject({super.key, required this.data, required this.text});

  @override
  State<GridObject> createState() => _GridObjectState();
}

class _GridObjectState extends State<GridObject> {


  @override
  Widget build(BuildContext context) {
    print("Widget rebuilt with data: ${widget.data}, ${widget.text}");
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: widget.data.isNotEmpty ? Colors.greenAccent : Colors.grey,
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
          ],
        ),
      ),
    );;
  }
}
