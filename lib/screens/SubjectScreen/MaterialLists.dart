
import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:dy_integrated_5/models/Subject.dart';
import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
import 'package:dy_integrated_5/providers/DatabaseProvider.dart';
import 'package:dy_integrated_5/providers/SearchProvider.dart';

import 'package:dy_integrated_5/services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MaterialLists extends ConsumerWidget {
  final Subject subject;
  const MaterialLists({super.key, required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {



    final materials = ref.watch(courseMaterialProvider);
    final searchTerm = ref.watch(searchProvider);
    print(searchTerm);





    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
      height: 450,

      child: materials.when(
          data: (data){


            List<CourseMaterial> filteredMaterials = data.where(
                    (material)=>material.name.toLowerCase().contains(searchTerm.toLowerCase())
            ).toList();
            print(filteredMaterials);


            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: filteredMaterials.length,

              itemBuilder: (context, index){

                return Container(

                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black87,
                        width: 1,


                      ),
                      boxShadow: [BoxShadow(
                        color: CustomColors.customGray,
                        blurRadius: 5,
                      )]
                  ),
                  child: ListTile(
                    onTap: (){
                      ref.read(databaseNotifierProvider.notifier).insert(filteredMaterials[index], subject.name);
                      ApiService.downloadResource(subject.name, filteredMaterials[index].name, filteredMaterials[index].link);
                    },


                    leading: const Icon(
                      Icons.document_scanner,
                      size: 32,
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          // File name
                          child: Text(
                            filteredMaterials[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),//File Type
                    subtitle: Text(filteredMaterials[index].type),
                    trailing: IconButton(
                      iconSize: 32,
                      onPressed: ()=>{

                        ApiService.downloadResource(subject.name, filteredMaterials[index].name, filteredMaterials[index].link, forceReFetch: true)
                      },
                      style: IconButton.styleFrom(
                        side: BorderSide(
                          color: CustomColors.customGray,

                        )
                      ),
                      icon: const Icon(
                          Icons.refresh_sharp
                      ),
                    ),



                  ),
                );
              },
            );
          },
          error: (error, stackTrace)=>const Text("You've done it again."),
          loading: ()=>const CircularProgressIndicator()
      ),

    );
  }
}



