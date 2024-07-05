
import 'package:dy_integrated_5/models/CourseMaterial.dart';
import 'package:dy_integrated_5/models/Subject.dart';
import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';

import 'package:dy_integrated_5/providers/SearchProvider.dart';

import 'package:dy_integrated_5/widgets/CustomListTile.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MaterialLists extends ConsumerWidget {
  final Subject subject;
  const MaterialLists({super.key, required this.subject});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final materials = ref.watch(courseMaterialProvider);
    final searchTerm = ref.watch(searchProvider);


    return SizedBox(
      // margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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

                  // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(10),
                      // color: Colors.white,
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.shade300,
                          width: 4,
                        )


                      ),
                      // boxShadow: [BoxShadow(
                      //   color: CustomColors.customGray,
                      //   blurRadius: 5,
                      // )]
                  ),
                  child: CustomListTile(
                    subject: subject,
                    filteredMaterials: filteredMaterials,
                    index: index,
                  )
                );
              },
            );
          },

          error: (error, stackTrace)=>const Text("You've done it again."),

          loading: ()=>const  Center(
              child: CircularProgressIndicator()
          )
      ),

    );
  }
}



