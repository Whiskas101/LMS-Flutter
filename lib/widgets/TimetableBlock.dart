import 'package:dy_integrated_5/utils/constants.dart';
import 'package:dy_integrated_5/utils/helpers.dart';
import 'package:flutter/material.dart';


class TimetableBlock extends StatelessWidget {
  final List<String> subjects;
  const TimetableBlock({super.key, required this.subjects});



  @override
  Widget build(BuildContext context) {


    print(subjects);
    print('got these');

    return Row(
      children: [
        ...subjects.asMap().entries.map((MapEntry<int, String> subject){
        return subject.value.isNotEmpty ? Container(
          constraints: const BoxConstraints(
            minWidth: 70
          ),

          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,


              )
            ],
            border: const Border.fromBorderSide(
              BorderSide(
                color: Colors.black87,
                width: 1,

              )
            )
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  subject.value,
                style:  TextStyle(
                  color: CustomColors.customDarkGrey3,
                  fontSize: 12,
                  fontWeight: FontWeight.w600
                ),
              ),
              Text(
                  timeAtIndexLinear(subject.key),
                style: TextStyle(
                  fontSize: 10,
                  color: CustomColors.customDarkGrey,
                ),
              ),
              // Text("${subject.key}")
            ],
          ),
        ) : Container();
      }),
        SizedBox(width: 50,)


      ],
    );
  }
}
