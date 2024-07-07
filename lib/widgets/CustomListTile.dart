import 'package:dy_integrated_5/utils/debouncer.dart';
import 'package:dy_integrated_5/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/CourseMaterial.dart';
import '../models/Subject.dart';
import '../providers/DatabaseProvider.dart';
import '../services/api_service.dart';


class CustomListTile extends ConsumerWidget {
  final int index;
  final List<CourseMaterial> filteredMaterials;
  final Subject subject;
  const CustomListTile({super.key, required this.index, required this.filteredMaterials, required this.subject});



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Throttler _throttler = Throttler();

    return ListTile(
      onTap: (){

        ref.read(databaseNotifierProvider.notifier).insert(filteredMaterials[index], subject.name);
        _throttler.run((){
          ApiService.downloadResource(subject.name, filteredMaterials[index].name, filteredMaterials[index].link);
        });
        // ApiService.downloadResource(subject.name, filteredMaterials[index].name, filteredMaterials[index].link);

      },


      leading: Icon(
        Icons.dashboard,
        size: 32,
        color: Colors.lightBlueAccent[200],
      ),
      title: Row(
        children: [
          Expanded(
            // File name
            child: Text(
              filteredMaterials[index].name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),//File Type
      subtitle: Text(
          filteredMaterials[index].type,
        style: const TextStyle(
            fontSize: 10,
        ),
      ),
      trailing: IconButton(
        iconSize: 32,
        onPressed: ()=>{

          ApiService.downloadResource(subject.name, filteredMaterials[index].name, filteredMaterials[index].link, forceReFetch: true)
        },
        style: IconButton.styleFrom(
            side: const BorderSide(
                color: Colors.lightBlueAccent,
                width: 0

            )
        ),
        icon: const Icon(
          Icons.refresh_sharp,


        ),
      ),



    );
  }
}
