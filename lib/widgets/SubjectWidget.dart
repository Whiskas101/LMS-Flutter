import 'package:dy_integrated_5/models/Subject.dart';

import 'package:flutter/material.dart';

// import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utils/constants.dart';
import '../utils/helpers.dart';

class SubjectWidget extends StatelessWidget {
  final Subject subject;

  const SubjectWidget({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10),
      //     color: Colors.white,
      //     border: const Border.fromBorderSide(BorderSide(width: 1)),
      //     // boxShadow: [BoxShadow(
      //     //     color: CustomColors.customDarkGrey3,
      //     //   //   blurRadius: 3,
      //     //   // spreadRadius: 0
      //     // )]
      // ),

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12), ),
          border: Border.all(
            width: 2,
            color: Colors.black12

          ),
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.grey.shade300,
        //       spreadRadius: 0.0,
        //       blurRadius: 5.0,
        //       offset: const Offset(3.0, 3.0)),
        //   BoxShadow(
        //       color: Colors.grey.shade400,
        //       spreadRadius: 0.0,
        //       blurRadius: 5 / 2.0,
        //       offset: const Offset(3.0, 3.0)),
        //
        // ],
      ),

      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                           child: Text(
                            shortFormOf(subject.name),
                            // subject.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: CustomColors.customDarkGrey2,
                                fontWeight: FontWeight.normal,
                              letterSpacing: -0.5
                            ),
                           ),
                        )
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                        child: Text(
                          subject.instructor,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              overflow: TextOverflow.visible,

                          ),
                        ),
                      ),
                    )
                  ],
                ),
                LinearProgressIndicator(
                  color: Colors.lightBlue,
                  minHeight: 15,
                  value: handlePercentage(subject.attendance),
                  backgroundColor: Colors.lightBlue.withOpacity(0.3),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                )
              ],
            ),
          ),


          // Circular Attendance Indicator
          // Column(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         decoration:  BoxDecoration(
          //             // color: Colors.blue.withOpacity(0.0),
          //             borderRadius:
          //                 BorderRadius.horizontal(right: Radius.circular(9))),
          //         child: Center(
          //             child: Container(
          //           padding: const EdgeInsets.symmetric(horizontal: 5),
          //           child: CircularPercentIndicator(
          //             radius: 20,
          //             lineWidth: 5,
          //             percent: handlePercentage(subject.attendance),
          //             progressColor: handlePercentage(subject.attendance) > 0.75
          //                 ? CustomColors.customBlue
          //                 : Colors.redAccent,
          //           ),
          //         )),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
