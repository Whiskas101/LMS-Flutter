import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
import 'package:dy_integrated_5/providers/SearchProvider.dart';
import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/SubjectScreen.dart';
import 'package:dy_integrated_5/widgets/SubjectWidget.dart';

import 'package:flutter/material.dart';

import 'package:dy_integrated_5/utils/constants.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/Subject.dart';


class SubjectGridSection extends HookConsumerWidget {
  const SubjectGridSection({super.key});









  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final semester = ref.watch(semesterNotifierProvider);





    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Your Courses",
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14,),

        //Subject Grid
        SizedBox(
          height: 350,


          child: semester.when(
              data: (semester){
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.7/1,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 0),


                  itemCount: semester.subjects.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () async {
                        ref.read(courseMaterialProvider.notifier).getCourseMaterials(semester.subjects[index].link);
                        ref.read(searchProvider.notifier).updateSearchTerm("");// setting the data for the materials
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>SubjectScreen(subject: semester.subjects[index]))
                        );
                      },
                      child: SubjectWidget(subject: semester.subjects[index])
                    );
                  },




                );
              },
              error: (error, stackTrace)=>Text("You fucked up."),
              loading: (){


                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    )
                  ],
                );



              }
          )


        ),
      ],
    );
  }
}
