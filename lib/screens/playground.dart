import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Semester.dart';




class Playground extends ConsumerWidget {
  const Playground({super.key});




  void doStuff(){
    ApiService.attemptLogin(
      'vik.cha.rt22@dypatil.edu',
      'dypatil@123'
    );

  }

  void doGetSubject(){
    ApiService.getSemesterData();
  }

  void doMaterialStuff(){
    // https://mydy.dypatil.edu/rait/course/view.php?id=5923
    // https://mydy.dypatil.edu/rait/course/view.php?id=5921
    // https://mydy.dypatil.edu/rait/course/view.php?id=5922,
    ApiService.getSubjectMaterial("https://mydy.dypatil.edu/rait/course/view.php?id=5921");
  }

  void doDownloadStuff(){
    // https://mydy.dypatil.edu/rait/mod/presentation/view.php?id=611990
    // https://mydy.dypatil.edu/rait/mod/presentation/view.php?id=612128
    // https://mydy.dypatil.edu/rait/mod/flexpaper/view.php?id=613117
    // https://mydy.dypatil.edu/rait/mod/presentation/view.php?id=614269
    print("Wow downloading shit");
    ApiService.downloadResource("TestingDownload","week 1 ppython_uw.pdf","https://mydy.dypatil.edu/rait/mod/presentation/view.php?id=611990");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final semester = ref.watch(semesterNotifierProvider);
    final materials = ref.watch(courseMaterialProvider);



    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                child: ElevatedButton(
                  onPressed: doStuff,
                  child: const Text("do stuff"),
                ),
              ),
              ElevatedButton(
                onPressed: (){

                  ref.read(semesterNotifierProvider.notifier).getSemesterData();

                },
                child: const Text("do subject stuff"),
              ),
              ElevatedButton(
                onPressed: (){
                  ref.read(courseMaterialProvider.notifier).getCourseMaterials("https://mydy.dypatil.edu/rait/course/view.php?id=5922");
                },
                child: const Text("do material stuff"),
              ),
              ElevatedButton(
                onPressed: doDownloadStuff,
                child: const Text("do download stuff"),
              ),

              Container(
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: materials.map((material){return Text(material.name);}).toList(),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
