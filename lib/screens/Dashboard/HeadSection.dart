import 'package:dy_integrated_5/providers/TimetableProvider.dart';
import 'package:dy_integrated_5/screens/TimetableScreen/GridObject.dart';
import 'package:dy_integrated_5/widgets/TimetableBlock.dart';
import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/TimeTable.dart';

class HeadSection extends ConsumerWidget {
  const HeadSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final timeTable = ref.watch(timetableNotifierProvider);


    return Column(
      children: [
        // FDY
        // APP NAME widget, with bottom text
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FDY",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    "LMS Wrapper",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                        color: Colors.white60
                    ),
                  ),
                ],


              ),
            )
          ],

        ),

        const SizedBox(height: 20,),

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
            data: (data){

              //Gets the day of the week as an int [1-7]
              int day = DateTime.now().weekday - 1;
              List<String> subjects = [];
              if(day < 5){
                int i;
                for (i = 0; i < data.timetable.length; i++){

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
                      return const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                        stops: [0.0, 0.02, 0.9, 1], // 10% purple, 80% transparent, 10% purple
                      ).createShader(bounds);
                    },
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: TimetableBlock(subjects: subjects)
                    ),
                  )
              );
              } else {
                return Text("No lectures for today");
              }

            },
            error: (error, stackTrace)=>const Text("Something went wrong"),
            loading: () => const CircularProgressIndicator()
        )


      ],
    );
  }
}
