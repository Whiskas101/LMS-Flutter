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
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              width: 1,
              color: Colors.black54
          ),
          boxShadow: [BoxShadow(
              color: CustomColors.customGray,
              blurRadius: 5
          )]
      ),
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
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    // color: Colors.red
                  ),

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
                              color: Colors.black87,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(

                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(

                        // color: Colors.pink
                      ),


                      // Faculty/Instructor name
                      child: Text(
                        subject.instructor,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            color: Colors.black87,
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
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color:Colors.black87,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(19))
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
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),

                progressColor: handlePercentage(subject.attendance) > 0.75 ? Colors.blueAccent : Colors.redAccent,
                curve: Curves.easeInOutCubicEmphasized,


              )
          )


        ],
      ),
    );
  }
}
