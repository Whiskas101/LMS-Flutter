import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            Icons.line_style_sharp,
            size: 32,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: IconButton(
              onPressed: ()=>ref.read(semesterNotifierProvider.notifier).getSemesterData(forceReFetch: true),
              icon: Icon(
                Icons.refresh,
                size: 32,
              ),
          )
        ),
      ],
    );
  }
}
