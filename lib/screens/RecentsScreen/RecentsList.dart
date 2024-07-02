import 'package:dy_integrated_5/providers/DatabaseProvider.dart';
import 'package:dy_integrated_5/providers/SearchProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import '../../models/CourseMaterial.dart';
import '../../models/Recents.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';


class RecentsList extends ConsumerWidget {
  const RecentsList({super.key});




  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final recentMaterials = ref.watch(databaseNotifierProvider);
    print("Got this: $recentMaterials");
    final searchTerm = ref.watch(searchProvider);



    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
      height: 570,

      child: recentMaterials.when(
          data: (data){

            print('$data is used here');

            List<Recent> filteredMaterials = data.where(
                    (recentObj)=>recentObj.material.name.toLowerCase().contains(searchTerm.toLowerCase())
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
                      ref.read(databaseNotifierProvider.notifier).insert(filteredMaterials[index].material, filteredMaterials[index].subject);
                      ApiService.downloadResource(filteredMaterials[index].subject, filteredMaterials[index].material.name, filteredMaterials[index].material.link);
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
                            filteredMaterials[index].material.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),//File Type
                    subtitle: Text(filteredMaterials[index].material.type),
                    trailing: IconButton(
                      iconSize: 32,
                      onPressed: ()=>{

                        ApiService.downloadResource(filteredMaterials[index].subject, filteredMaterials[index].material.name, filteredMaterials[index].material.link, forceReFetch: true)
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
          loading: ()=>Text("Loading")
      ),

    );
  }
}
