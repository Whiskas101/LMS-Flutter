import 'package:dy_integrated_5/models/Subject.dart';
import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
import 'package:dy_integrated_5/utils/debouncer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenTitle extends ConsumerWidget {
  final Subject subject;
  ScreenTitle({super.key, required this.subject});
  final Throttler refreshThrottler = Throttler();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        //Leading Icon
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.exit_to_app,
                size: 32, color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),

        // Screen Name [course material]
        Expanded(
          child: Text(
            "Course",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
                letterSpacing: 1.3),
          ),
        ),

        //Refresh Button
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: IconButton(
            icon: Icon(Icons.refresh_sharp,
                size: 32, color: Theme.of(context).colorScheme.onPrimary),
            onPressed: () => refreshThrottler.run(() {
              // print("${subject.link} fetch");
              ref
                  .read(courseMaterialProvider.notifier)
                  .getCourseMaterials(subject.link, forceReFetch: true);
            }),
          ),
        ),
      ],
    );
  }
}
