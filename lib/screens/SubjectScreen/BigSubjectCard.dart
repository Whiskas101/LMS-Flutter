import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BigSubjectCard extends StatefulWidget {
  const BigSubjectCard({super.key});

  @override
  State<BigSubjectCard> createState() => _BigSubjectCardState();
}

class _BigSubjectCardState extends State<BigSubjectCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
                        child: Text(
                          "Principles of Communications Engineering",
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

                      child: Text(
                        "Some Weird Faculty name",
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
                percent: 0.9,
                animation: true,
                // animateFromLastPercent: true,

                progressColor: Colors.blueAccent,
                curve: Curves.easeInOutCubicEmphasized,


              )
          )


        ],
      ),
    );
  }
}
