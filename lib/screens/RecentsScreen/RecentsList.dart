import 'package:dy_integrated_5/providers/DatabaseProvider.dart';
import 'package:dy_integrated_5/providers/SearchProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

import '../../models/Recents.dart';
import 'RecentListTile.dart';


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


            return ShaderMask(
              blendMode: BlendMode.dstOut,
              shaderCallback: (Rect bounds) { 
               return const LinearGradient(
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                 stops: [0.0, 0.02, 0.9, 1], // 10% purple, 80% transparent, 10% purple
               ).createShader(bounds);
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filteredMaterials.length,
              
                itemBuilder: (context, index){

                  return RecentListTile(
                    index: index,
                    filteredMaterials: filteredMaterials,
                  );
                },
              ),
            );
          },
          error: (error, stackTrace)=>const Text("You've done it again."),
          loading: ()=>Text("Loading")
      ),

    );
  }
}
