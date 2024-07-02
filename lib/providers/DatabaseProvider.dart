

import 'dart:async';


import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:dy_integrated_5/services/db_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Recents.dart';


class DatabaseNotifier extends AsyncNotifier<List<Recent>>{
  @override
  Future<List<Recent>> build() async {
    state = const AsyncLoading<List<Recent>>();
    List<Recent> materials = await DatabaseService.instance.getRecent(30);


    // print("Materials is : $materials");
    state = AsyncData(materials);
    return materials;
    // return materials;
  }

  Future<List<Recent>> getRecent() async {
    state = const AsyncLoading<List<Recent>>();
    List<Recent> materials = await DatabaseService.instance.getRecent(30);
    print("Materials is : $materials");
    state = AsyncData<List<Recent>>(materials);
    print("Set the state to taht");
    return materials;
  }

  void insert(CourseMaterial material, String subject)async{
    print("$material $subject was added");
    await DatabaseService.instance.addRecent(material, subject);
  }

  //
  // void delete()async{
  //   DatabaseService.instance.delete();
  // }


}



final databaseNotifierProvider = AsyncNotifierProvider<DatabaseNotifier, List<Recent>>(
        ()=>DatabaseNotifier()
);