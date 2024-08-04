// For state
import 'package:dy_integrated_5/utils/helpers.dart';
import 'package:dy_integrated_5/widgets/LimitWidth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/providers/TimetableProvider.dart';

// Structural Components
import 'package:dy_integrated_5/screens/TimetableScreen/DaysHeader.dart';
import 'package:dy_integrated_5/screens/TimetableScreen/DraggableSubjectsGrid.dart';
import 'package:dy_integrated_5/screens/TimetableScreen/GridObject.dart';
import 'package:dy_integrated_5/screens/TimetableScreen/ScreenTitle.dart';

// Framework
import 'package:flutter/material.dart';

class TimetableScreen extends ConsumerWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(timetableNotifierProvider);
    final semester = ref.watch(semesterNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: LimitWidth(
        child: Column(
          children: [
            // Title name
            Flexible(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12.0, 20, 12, 0),
                decoration: const BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black87,
                          blurRadius: 8,
                          offset: Offset(0, -3),
                          spreadRadius: 1)
                    ]),
                child: const Column(
                  children: [
                    SizedBox(
                      height: 34,
                    ),

                    ScreenTitle(),

                    //Days of the week (working)
                    Expanded(child: DaysHeader()),
                  ],
                ),
              ),
            ),

            //Time Table Matrix
            Flexible(
              flex: 4,
              child: data.when(
                  data: (data) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade100,
                              Colors.grey.shade50,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        boxShadow: [
                          //top left shadow
                          BoxShadow(
                              color: Colors.grey.shade50,
                              offset: const Offset(-10, -1),
                              blurRadius: 15,
                              spreadRadius: 1),

                          //Bottom right shadow
                          BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(15, 15),
                              blurRadius: 15,
                              spreadRadius: 14)
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          // scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 2,
                                  childAspectRatio:
                                      isDesktopType() ? 2 / 1 : 1),
                          itemCount: data.timetable.length *
                              5, // 5 refers to no. of working days

                          itemBuilder: (BuildContext context, int index) {
                            final row = (index ~/ 5);
                            final col = index % 5;

                            return DragTarget<AcceptState>(
                              onAcceptWithDetails: (dragDetails) {
                                print("Accepted");
                                ref
                                    .read(timetableNotifierProvider.notifier)
                                    .setValue(dragDetails.data.text, row, col);
                              },
                              builder: (context, candidateData, rejectedData) =>
                                  GridObject(
                                index: index,
                                data: data.timetable[row][col],
                                text: data.valueAtIndex(index),
                                row: row,
                                col: col,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator()),
            ),

            //Subjects to be dragged into timetable
            semester.when(
                data: (semester) => Expanded(
                        child: DraggableSubjectsGrid(
                      semester: semester,
                    )),
                error: (error, stackTrace) =>
                    const Text("Something went wrong"),
                loading: () => const CircularProgressIndicator()),

            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
