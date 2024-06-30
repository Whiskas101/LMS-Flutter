import 'package:dy_integrated_5/models/Subject.dart';
import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenTitle extends ConsumerWidget {
  final Subject subject;
  const ScreenTitle({super.key, required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Row(

      children: [
        //Leading Icon
        Icon(
          Icons.book,
          size: 32,

        ),

        // Screen Name [course material]
        Expanded(
          child: Text(
            "Course Material",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

        //Refresh Button
        Padding(
          padding: const EdgeInsets.fromLTRB(0,0,8,0),
          child: IconButton(
            icon:Icon(
              Icons.refresh_sharp,
              size: 32,
            ),
            onPressed: (){
              print("${subject.link} fetch");
              ref.read(courseMaterialProvider.notifier).getCourseMaterials(subject.link);
            },

          ),
        ),


      ],
    );
  }
}
