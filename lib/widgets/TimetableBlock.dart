import 'package:dy_integrated_5/utils/constants.dart';
import 'package:dy_integrated_5/utils/helpers.dart';
import 'package:flutter/material.dart';

class TimetableBlock extends StatelessWidget {
  final List<String> subjects;
  const TimetableBlock({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...subjects.asMap().entries.map((MapEntry<int, String> subject) {
          return subject.value.isNotEmpty
              ? Container(
                  constraints: const BoxConstraints(minWidth: 70),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surface.withOpacity(1),
                      borderRadius: BorderRadius.circular(14),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Theme.of(context).colorScheme.inversePrimary,
                      //     blurRadius: 4,
                      //   )
                      // ],
                      border: Border.fromBorderSide(BorderSide(
                        color: Theme.of(context).colorScheme.shadow,
                        width: 2,
                      ))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        subject.value,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        timeAtIndexLinear(subject.key),
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      // Text("${subject.key}")
                    ],
                  ),
                )
              : Container();
        }),
        const SizedBox(
          width: 50,
        )
      ],
    );
  }
}
