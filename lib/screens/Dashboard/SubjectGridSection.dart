import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
import 'package:dy_integrated_5/providers/SearchProvider.dart';
import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/SubjectScreen.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:dy_integrated_5/utils/debouncer.dart';
import 'package:dy_integrated_5/widgets/SubjectWidget.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubjectGridSection extends ConsumerWidget {
  SubjectGridSection({super.key});

  final Throttler refreshThrottler = Throttler();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semester = ref.watch(semesterNotifierProvider);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
        // color: Colors.red,
        borderRadius: BorderRadius.circular(15),
        // gradient: LinearGradient(
        //     colors: [
        //       Colors.grey.shade100,
        //       Colors.grey.shade50,
        //     ],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight
        // ),
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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 3,
                        color: Theme.of(context).colorScheme.surface))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 0),
                    child: Text(
                      "Your Courses",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                ),
                Icon(
                  Icons.menu_book,
                  color: Theme.of(context).colorScheme.tertiary,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),

          //Subject Grid
          Expanded(
              child: semester.when(
                  data: (semester) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              (MediaQuery.sizeOf(context).longestSide ~/ 300)
                                  .floor(),
                          childAspectRatio: 1.8 / 1, // Width : Height ratio
                          // mainAxisSpacing: 20,
                          crossAxisSpacing: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      itemCount: semester.subjects.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () async {
                              refreshThrottler.run(() {
                                ref
                                    .read(courseMaterialProvider.notifier)
                                    .getCourseMaterials(
                                        semester.subjects[index].link);
                              });
                              ref
                                  .read(searchProvider.notifier)
                                  .updateSearchTerm(
                                      ""); // setting the data for the materials
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SubjectScreen(
                                          subject: semester.subjects[index])));
                            },
                            child: SubjectWidget(
                                subject: semester.subjects[index]));
                      },
                    );
                  },
                  error: (error, stackTrace) => const Text("You fucked up."),
                  loading: () {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.blueAccent,
                        )
                      ],
                    );
                  })),
        ],
      ),
    );
  }
}
