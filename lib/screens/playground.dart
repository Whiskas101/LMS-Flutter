

import 'dart:convert';

import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
import 'package:dy_integrated_5/providers/SemesterProvider.dart';

import 'package:dy_integrated_5/services/api_service.dart';
import 'package:dy_integrated_5/services/db_service.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';





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


  void pushToDB() async {
    Map<String, dynamic> data = {
      'link':'https://mydy.dypatil.edu/rait/mod/resource/view.php?id=609024',
      'name':'notasubject',
      'type':'notminelmao'
    };
    
    CourseMaterial course = CourseMaterial.fromJSON(data);

    String link = "https://mydy.dypatil.edu/rait/mod/resource/view.php?id=609024";



    // DatabaseService.instance.delete();
    print("fone");
    // List<CourseMaterial> stuff = fetchedData.map(
    //     (row){
    //       final raw = row['material'] as String;
    //
    //
    //       Map<String, dynamic> jsonData = jsonDecode(raw);
    //       return CourseMaterial.fromJSON(jsonData);
    //
    //
    //     }
    // ).toList();

    // print(stuff);
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


              SizedBox(height: 20,),
              ElevatedButton(onPressed: pushToDB, child: Text("Datapush"))



            ],
          ),
        ),
      ),
    );
  }
}
