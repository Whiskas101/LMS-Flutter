import 'package:dy_integrated_5/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
// import 'package:dy_integrated_5/utils/helpers.dart';

class DaysHeader extends ConsumerWidget {
  const DaysHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      // decoration: BoxDecoration(
      //     // color: Colors.red,
      //     ),
      // height: 10,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 4,
          mainAxisSpacing: 1,

          // childAspectRatio: isDesktopType() ? (2 / 1) : 1
        ),
        itemCount: 5, // 5 for Five Working days of the week

        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(2),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerLow
                    .withAlpha(90),
                // color: Colors.red,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                dayAtIndex(index),
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          );
        },
      ),
    );
  }
}
