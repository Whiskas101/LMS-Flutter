
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DaysHeader extends ConsumerWidget {

  const DaysHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


          return Container(

            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            height: 100,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 5,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 2
              ),
              itemCount: 5, // 5 for Five Working days of the week


              itemBuilder: (BuildContext context, int index) {

                return Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: Center(
                    child: Text(
                      dayAtIndex(index),
                      style: TextStyle(
                          color: CustomColors.customDarkGrey3
                      ),
                    ),
                  ),
                );
              },

            ),
          );


  }
}
