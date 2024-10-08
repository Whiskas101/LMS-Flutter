import 'package:dy_integrated_5/providers/DatabaseProvider.dart';
import 'package:dy_integrated_5/providers/SearchProvider.dart';
import 'package:dy_integrated_5/screens/RecentsScreen/RecentsScreen.dart';
import 'package:dy_integrated_5/screens/TimetableScreen/TimetableScreen.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class QuickJump extends StatelessWidget {
  const QuickJump({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //     width: 2,
        //   color: CustomColors.customDarkGrey3.withOpacity(0.7)
        // ),
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade100,
            Colors.grey.shade50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
        boxShadow: [
          //top left shadow
          BoxShadow(
            color: Colors.grey.shade50,
            offset: const Offset(-15, -15),
            blurRadius: 15,
            spreadRadius: 1

          ),

          //Bottom right shadow
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(15,15),
              blurRadius: 15,
            spreadRadius: 1
          )

        ],
      ),




      child: Column(
        children: [
      
          //QUICK JUMP [JUST TITLE]
           Container(
             padding: const EdgeInsets.symmetric(vertical: 4),
             decoration: BoxDecoration(
                 // color: CustomColors.customDarkGrey.withOpacity(0.9),
                 borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                 border: Border(
                     bottom: BorderSide(
                         width: 3,
                         color: Colors.grey.shade300
                     )
                 )
             ),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "Quick Jump",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                          fontSize: 18,
                        color: CustomColors.customDarkGrey3
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                      Icons.electric_bolt_sharp,
                    color: Colors.yellow,

                  ),
                )

              ],


             ),
           ),
      
      

      
          //Quick Jump Items [The actual buttons]
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10),
            child: Row(
              children: [
                // Timetable
                Listener(
                  onPointerDown: (event)=>{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const TimetableScreen()))

                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 10),

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),




                        boxShadow: const [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1
                        )]
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.receipt_long_outlined,
                          color: Colors.lightBlue,
                          size: 28,
                        ),
                        const SizedBox(width: 5,),
                        Text(
                            "Timetable",
                          style: TextStyle(
                            color: CustomColors.customDarkGrey2
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                //TO REPLACE WITH LISTENER HERE [Recents]
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),



                      boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1
                      )]
                  ),

                  child: Consumer(
                    builder: (context, ref, child) {
                      return GestureDetector(
                        onTap: (){
                          ref.read(searchProvider.notifier).updateSearchTerm("");
                          ref.read(databaseNotifierProvider.notifier).getRecent();
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> const RecentsScreen())
                          );

                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.timelapse_rounded,
                              size: 28,
                              color: Colors.lightBlue,
                            ),
                            const SizedBox(width: 4,),

                            Text(
                                "Recent",
                              style: TextStyle(
                                color: CustomColors.customDarkGrey2
                              ),
                            )
                          ],
                        ),
                      );
                    },

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
