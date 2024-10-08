import 'package:dy_integrated_5/utils/debouncer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../models/Recents.dart';
import '../../providers/DatabaseProvider.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';


class RecentListTile extends ConsumerWidget {
  final int index;
  final List<Recent> filteredMaterials;
  RecentListTile({super.key, required this.index, required this.filteredMaterials});

  final Throttler refreshThrottler =  Throttler();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(

      // margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.vertical(
          //   bottom: Radius.circular(15)
          // ),


          border: Border.symmetric(
            horizontal: BorderSide(
              width: 2,
              color: Colors.grey.shade300
            )
          ),



          // boxShadow: [BoxShadow(
          //   color: CustomColors.customGray,
          //   blurRadius: 5,
          // )]
      ),
      child: ListTile(
        onTap: () async {
          refreshThrottler.run((){
            ref.read(databaseNotifierProvider.notifier).insert(filteredMaterials[index].material, filteredMaterials[index].subject);
            ApiService.downloadResource(filteredMaterials[index].subject, filteredMaterials[index].material.name, filteredMaterials[index].material.link);
          });
        },


        leading: Icon(
          Icons.dashboard,
          size: 32,
          color: Colors.lightBlue.shade300,
        ),
        title: Row(
          children: [
            Expanded(
              // File name
              child: Text(
                filteredMaterials[index].material.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14
                ),

              ),
            ),
          ],
        ),//File Type

        subtitle: Text(
            filteredMaterials[index].material.type,
          style: const TextStyle(
            fontSize: 12
          ),

        ),
        // trailing: IconButton(
        //   iconSize: 32,
        //   onPressed: ()=>refreshThrottler.run((){
        //     ApiService.downloadResource(filteredMaterials[index].subject, filteredMaterials[index].material.name, filteredMaterials[index].material.link, forceReFetch: true);
        //   }),
        //   style: IconButton.styleFrom(
        //       side: BorderSide(
        //         color: CustomColors.customGray,
        //
        //       )
        //   ),
        //   icon: const Icon(
        //       Icons.refresh_sharp
        //   ),
        // ),



      ),
    );
  }
}
