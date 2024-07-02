

import 'package:dy_integrated_5/models/Subject.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utils/constants.dart';
import '../utils/helpers.dart';


class SubjectWidget extends StatelessWidget {
  final Subject subject;

  const SubjectWidget({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: const Border.fromBorderSide(BorderSide(width: 1)),
          boxShadow: [BoxShadow(
              color: CustomColors.customGray,
              blurRadius: 2
          )]
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
                              overflow: TextOverflow.visible,
                              maxLines: 3,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          subject.instructor,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            overflow: TextOverflow.visible
                          ),

                        ),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
          Column(

            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(9))
                  ),

                  child: Center(

                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: CircularPercentIndicator(
                          radius: 20,
                          lineWidth: 5,
                          percent: handlePercentage(subject.attendance),
                          progressColor: handlePercentage(subject.attendance) > 0.75 ? Colors.blueAccent : Colors.redAccent,
                        ),
                      )
                  ),
                ),
              ),
            ],
          )
        ],

      ),


    );
  }
}
