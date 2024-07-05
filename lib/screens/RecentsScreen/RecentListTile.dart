import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../models/Recents.dart';
import '../../providers/DatabaseProvider.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';


class RecentListTile extends ConsumerWidget {
  final int index;
  final List<Recent> filteredMaterials;
  const RecentListTile({super.key, required this.index, required this.filteredMaterials});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onTap: () async {
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
  }
}
