
import 'package:dy_integrated_5/models/Subject.dart';
import 'package:dy_integrated_5/providers/CourseMaterialProvider.dart';
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

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 20),
      height: 450,

      child: materials.when(
          data: (data){
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,

              itemBuilder: (context, index){

                return GestureDetector(
                  onTap: ()=>ApiService.downloadResource(subject.name, data[index].name, data[index].link), //data refers to the list of course material objects
                  child: Container(
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
                      leading: Icon(
                        Icons.document_scanner,
                        size: 32,
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            // File name
                            child: Text(
                              data[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),//File Type
                      subtitle: Text(data[index].type),
                      trailing: Icon(
                          Icons.refresh_sharp
                      ),
                  
                  
                  
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace)=>Text("You've done it again."),
          loading: ()=>CircularProgressIndicator()
      ),

    );
  }
}



