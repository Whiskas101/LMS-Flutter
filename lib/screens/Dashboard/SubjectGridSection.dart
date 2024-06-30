import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/SubjectScreen.dart';

import 'package:flutter/material.dart';

import 'package:dy_integrated_5/utils/constants.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class SubjectGridSection extends HookConsumerWidget {
  const SubjectGridSection({super.key});





  String shortFormOf(String title){
    String result = "";

    List<String> Words = title.split(" ");
    int i;
    for (i = 0; i < Words.length; i++){
      String word = Words[i];
      
      // Checking if the first letter of the word is upper case. if so, add it to the result;
      if(word[0] == word[0].toUpperCase()){
        result += word[0];
      }
    }
    return result;
  }
  String handlePercentage(String percentage){
    String temp = percentage.substring(0, percentage.length - 1);
    String percent = double.parse(temp).toStringAsFixed(0);
    return "$percent%";
  }


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
                        ref.read(courseMaterialProvider.notifier).getCourseMaterials(semester.subjects[index].link); // setting the data for the materials
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=>SubjectScreen(subject: semester.subjects[index]))
                        );
                      },
                      child: Container(

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
                                                shortFormOf(semester.subjects[index].name),
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          semester.subjects[index].instructor,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey
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

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Text(
                                            handlePercentage(semester.subjects[index].attendance),
                                            style: TextStyle(
                                                color: Colors.white
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],

                        ),


                      ),
                    );
                  },




                );
              },
              error: (error, stackTrace)=>Text("You fucked up."),
              loading: ()=>CircularProgressIndicator()
          )


        ),
      ],
    );
  }
}
