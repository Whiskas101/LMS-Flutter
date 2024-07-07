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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            Icons.line_style_sharp,
            size: 32,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: IconButton(
              onPressed: (){
                refreshThrottler.run((){
                  ref.read(semesterNotifierProvider.notifier).getSemesterData(forceReFetch: true);
                });
              },
              icon: const Icon(
                Icons.refresh,
                size: 32,
              ),
          )
        ),
      ],
    );
  }
}
