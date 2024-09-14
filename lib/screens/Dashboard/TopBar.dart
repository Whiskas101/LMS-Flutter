import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/utils/debouncer.dart';
import 'package:dy_integrated_5/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerWidget {
  TopBar({super.key});
  final refreshThrottler = Throttler();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              onPressed: () {
                refreshThrottler.run(() {
                  ref
                      .read(semesterNotifierProvider.notifier)
                      .getSemesterData(forceReFetch: true);
                });
              },
              icon: Icon(Icons.refresh,
                  size: 32, color: Theme.of(context).colorScheme.onSurface),
            )),
      ],
    );
  }
}
