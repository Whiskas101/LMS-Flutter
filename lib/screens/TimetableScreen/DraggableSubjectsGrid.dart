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

  const DraggableSubjectsGrid({super.key, required this.semester});

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

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        //Here is the design
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4)
            // gradient: LinearGradient(colors: [
            //   Colors.grey.shade100,
            //   Colors.grey.shade50,
            // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            // boxShadow: [
            //   //top left shadow
            //   BoxShadow(
            //       color: Colors.grey.shade50,
            //       offset: const Offset(-10, -10),
            //       blurRadius: 15,
            //       spreadRadius: 1),

            //   //Bottom right shadow
            //   BoxShadow(
            //       color: Colors.grey.shade300,
            //       offset: const Offset(15, 15),
            //       blurRadius: 15,
            //       spreadRadius: 14)
            // ],
            ),

        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          scrollDirection: Axis.horizontal,
          itemCount: generatedSubjects.length,
          itemBuilder: (context, index) {
            return Draggable(
              //Actual data that is being carried by the draggable object
              data: AcceptState(
                  text: generatedSubjects[index],
                  color: Theme.of(context).colorScheme.primary),

              childWhenDragging: Container(
                margin: const EdgeInsets.all(2),
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    generatedSubjects[index],
                    style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),

              feedback: Container(
                decoration: BoxDecoration(
                    color: getSubjectColor(generatedSubjects[index], context),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
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
                  color: getSubjectColor(generatedSubjects[index], context),
                  borderRadius: BorderRadius.circular(10),
                ),
                // border: Border.all(color: Colors.black87)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(generatedSubjects[index],
                              maxLines: 2,
                              softWrap: true,
                              style: const TextStyle(
                                overflow: TextOverflow.visible,
                                fontSize: 10,
                                color: Colors.black26,
                              )),
                        ),
                      ),
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
