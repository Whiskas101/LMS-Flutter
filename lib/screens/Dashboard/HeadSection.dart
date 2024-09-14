import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/providers/TimetableProvider.dart';
import 'package:dy_integrated_5/utils/helpers.dart';
import 'package:dy_integrated_5/widgets/TimetableBlock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadSection extends ConsumerWidget {
  const HeadSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeTable = ref.watch(timetableNotifierProvider);
    final semester = ref.watch(semesterNotifierProvider);

    return Column(
      children: [
        // FDY
        // APP NAME widget, with bottom text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FDY",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  Text(
                    "LMS Wrapper",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ],
              ),
            ),
            semester.when(
              data: (sem) {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      overallAttendance(sem),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  Text(
                    "Overall",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ]);
              },
              error: (err, stackTrace) => const Text("??%"),
              loading: () => const CircularProgressIndicator(),
            )
          ],
        ),

        const SizedBox(
          height: 20,
        ),

        //Search bar//

        // Container(
        //   height: 55,
        //   margin: const EdgeInsets.symmetric(horizontal: 8.0),
        //
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(10),
        //       border: Border.fromBorderSide(
        //         BorderSide(width: 1,
        //             color: CustomColors.customGray
        //         ),
        //       ),
        //       boxShadow: [
        //         BoxShadow(
        //             color: CustomColors.customGray,
        //             blurRadius: 1
        //
        //         )
        //       ]
        //
        //   ),
        //
        //   child: const Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //
        //       Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 12.0),
        //         child: Icon(
        //             Icons.search
        //         ),
        //       ),
        //
        //       Flexible(
        //         child: TextField(
        //
        //           decoration: null,
        //         ),
        //       ),
        //
        //       Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 12.0),
        //         child: Icon(
        //             Icons.keyboard_option_key
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        timeTable.when(
            data: (data) {
              //Gets the day of the week as an int [1-7]
              int day = DateTime.now().weekday - 1;
              List<String> subjects = [];
              if (day < 5) {
                int i;
                for (i = 0; i < data.timetable.length; i++) {
                  subjects.add(data.timetable[i][day]);
                }
                print(subjects.length);
              }
              if (day < 5) {
                return SizedBox(
                    height: 70,
                    child: ShaderMask(
                      blendMode: BlendMode.dstOut,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Colors.transparent,
                            Colors.transparent,
                            Theme.of(context).colorScheme.primary
                          ],
                          stops: const [
                            0.0,
                            0.02,
                            0.9,
                            1
                          ], // 10% purple, 80% transparent, 10% purple
                        ).createShader(bounds);
                      },
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: TimetableBlock(subjects: subjects)),
                    ));
              } else {
                return const Text("");
              }
            },
            error: (error, stackTrace) => const Text("Something went wrong"),
            loading: () => const CircularProgressIndicator())
      ],
    );
  }
}
