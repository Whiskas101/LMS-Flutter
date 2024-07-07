import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:dy_integrated_5/utils/helpers.dart';

import '../../models/Subject.dart';

class BigSubjectCard extends StatelessWidget {
  final Subject subject;
  const BigSubjectCard({super.key, required this.subject});



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),

      //   decoration: BoxDecoration(
      //
      //     // borderRadius: BorderRadius.circular(20),
      //     // border: Border.all(
      //     //     width: 1,
      //     //     color: Colors.black54
      //     // ),
      //     // boxShadow: [BoxShadow(
      //     //     color: CustomColors.customGray,
      //     //     blurRadius: 5
      //     // )]
      // ),

      height: 175,


      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Interesting how the expanded widget prevents the overflow in the sub child text despite not being a direct parent, might be useful
          // Course and Faculty Name section
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),


                  child: Row(
                    children: [
                      Expanded(
                        //Subject name
                        child: Text(
                          subject.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                          style: TextStyle(
                              color: CustomColors.customDarkGrey3,
                              fontSize: 18,
                            letterSpacing: -0.5
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(

                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),

                      // Faculty/Instructor name
                      child: Text(
                        subject.instructor,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: CustomColors.customDarkGrey3,
                            fontSize: 10
                        ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),


          // Percentage Visualisation section
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),

              decoration: BoxDecoration(
                // color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15)
                  ),

                border: Border(
                    left: BorderSide(width: 5,
                    color: Colors.grey.shade300)
                )



              ),



              child: CircularPercentIndicator(
                radius: 55,
                lineWidth: 12,
                animationDuration: 3000,
                percent: handlePercentage(subject.attendance),
                animation: true,
                // animateFromLastPercent: true,
                center: Text(
                  "${(handlePercentage(subject.attendance, floor: true)*100).toInt()}%",
                  style: TextStyle(
                    fontSize: 18,
                    color: handlePercentage(subject.attendance) > 0.75 ? Colors.lightBlueAccent : Colors.redAccent,

                  ),
                ),

                progressColor: handlePercentage(subject.attendance) > 0.75 ? Colors.lightBlueAccent : Colors.redAccent,
                curve: Curves.easeInOutCubicEmphasized,


              )
          )


        ],
      ),
    );
  }
}
