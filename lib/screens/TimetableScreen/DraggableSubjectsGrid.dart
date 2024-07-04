import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/Semester.dart';

import 'package:dy_integrated_5/utils/helpers.dart';

// Helper class
class AcceptState {
  Color color;
  String text;

  AcceptState({required this.color, required this.text});
}

class DraggableSubjectsGrid extends StatelessWidget {
  final Semester semester;

  DraggableSubjectsGrid({super.key, required this.semester});

  @override
  Widget build(BuildContext context) {
    late List<String> generatedSubjects = [];

    // Extracting subject names from semester
    List<String> subjectNames =
        semester.subjects.map((subject) => shortFormOf(subject.name)).toList();

    int i = 0;
    for (i = 0; i < subjectNames.length; i++) {
      generatedSubjects.add(subjectNames[i]);
      generatedSubjects.add("${subjectNames[i]} LAB");
    }

    generatedSubjects.add("MP");
    generatedSubjects.add("Break");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      height: 125,
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        scrollDirection: Axis.horizontal,
        itemCount: generatedSubjects.length,
        itemBuilder: (context, index) {
          return Draggable(
            //Actual data that is being carried by the draggable object
            data: AcceptState(
                text: generatedSubjects[index], color: Colors.greenAccent),

            childWhenDragging: Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  generatedSubjects[index],
                  style: const TextStyle(fontSize: 10, color: Colors.black26),
                ),
              ),
            ),

            feedback: Container(
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent, borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    generatedSubjects[index],
                    style: const TextStyle(
                        color: Colors.black26,
                        fontSize: 12,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ),

            child: Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Expanded(
                  child: Center(
                    child: Text(
                        generatedSubjects[index],
                        maxLines: 2,
                        softWrap: true,
                        style: const TextStyle(
                          overflow: TextOverflow.visible,
                            fontSize: 10, color: Colors.black26,


                        )
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
