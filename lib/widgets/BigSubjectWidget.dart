import 'package:dy_integrated_5/models/Attendance.dart';
import 'package:dy_integrated_5/models/Subject.dart';
import 'package:dy_integrated_5/utils/helpers.dart';
import 'package:flutter/material.dart';

class BigSubjectWidget extends StatelessWidget {
  /// BigSubjectWidget is for the Attendance Screen, different from
  /// the BigSubjectCard which only exists for the course name
  /// (Yes, I am indeed gifted at naming things.)

  final Attendance attendanceData;
  const BigSubjectWidget({super.key, required this.attendanceData});

  String catchUpMessage({double goal = 0.75}) {
    final skipAmt =
        attendanceData.skippableClassesIf(min_attendance_percentage: goal);
    final needAmt =
        attendanceData.requiredClassesIf(min_attendance_percentage: goal);
    // print("Need amt: $needAmt");
    String message = "";
    if (skipAmt == 1) {
      message = "Can skip one lecture";
    } else if (skipAmt == 0 && needAmt == 0) {
      message = "Can't skip any lectures";
    } else if (needAmt == 1) {
      message = "Need to attend one more lecture";
    } else if (needAmt > 1) {
      message = "Need to attend $needAmt lectures";
    }

    return message;
  }

  @override
  Widget build(BuildContext context) {
    final isZero = attendanceData.total == 0;

    return SizedBox(
      height: 110,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 1,
              children: [
                // NAME of the subject the .subject here is NOT of type subject model
                Text(
                  attendanceData.subject,
                  style: TextStyle(
                    color:
                        Theme.of(context).colorScheme.secondary.withAlpha(220),
                    fontSize: 16,
                    letterSpacing: 0.9,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                // Data for subject
                Row(
                  spacing: 5,
                  children: [
                    // current attendance information
                    // percentage format
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Text(
                            toPercentageString(attendanceData.percentage),
                            style: TextStyle(
                              color: isZero
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withAlpha(100)
                                  : Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // X/Y format for attendance
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Text(
                            '${attendanceData.present}/${attendanceData.total}',
                            style: TextStyle(
                              color: isZero
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withAlpha(100)
                                  : Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Spacer(),

                // Text to show how many classes can be skipped or are needed to be caught up
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: !isZero
                      ? Text(
                          catchUpMessage(),
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withAlpha(200),
                            fontSize: 12,
                            letterSpacing: 0.9,
                            // fontWeight: FontWeight.w700,
                          ),
                        )
                      : Text(
                          "No data yet",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withAlpha(200),
                            fontSize: 12,
                            letterSpacing: 0.9,
                            // fontWeight: FontWeight.w700,
                          ),
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
