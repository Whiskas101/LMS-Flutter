import 'package:dy_integrated_5/providers/TimetableProvider.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class ScreenTitle extends ConsumerWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            "Your Timetable",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              color: Colors.grey.shade50
            ),
            


          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: ElevatedButton(
              onPressed: () async {
                bool success = await ref.read(timetableNotifierProvider.notifier).save();
                if(success == true){
                  print("Saved timetable");
                  Future.delayed(
                      const Duration(milliseconds: 200),
                          ()=>Navigator.pop(context)
                  );
                }else{
                  print("Something went wrong.");
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0.5,
                backgroundColor: Colors.yellow,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    width: 2,
                    color: CustomColors.customDarkGrey3
                  )
                )
              ),

              child: const Text(
                  "Save",
                style: TextStyle(

                  color: Colors.black
                ),
              )
          ),
        )
      ],
    );
  }
}
