import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/constants.dart';

class HeadSection extends StatelessWidget {
  const HeadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FDY
        // APP NAME widget, with bottom text
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "FDY",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "LMS Wrapper",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                        color: CustomColors.customGray
                    ),
                  ),
                ],


              ),
            )
          ],

        ),

        const SizedBox(height: 20,),

        //Search bar
        Container(
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.fromBorderSide(
                BorderSide(width: 1,
                    color: CustomColors.customGray
                ),
              ),
              boxShadow: [
                BoxShadow(
                    color: CustomColors.customGray,
                    blurRadius: 1

                )
              ]

          ),

          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(
                    Icons.search
                ),
              ),

              Flexible(
                child: TextField(

                  decoration: null,
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(
                    Icons.keyboard_option_key
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
