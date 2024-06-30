import 'package:flutter/material.dart';


class QuickJump extends StatelessWidget {
  const QuickJump({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //QUICK JUMP [JUST TITLE]
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Quick Jump",
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            ),
          ],


        ),


        const SizedBox(height: 14,),

        //Quick Jump Items [The actual buttons]
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Row(

            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: const Border.fromBorderSide(BorderSide(width: 1)),



                    boxShadow: const [BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2
                    )]
                ),

                child: const Row(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 28,
                    ),

                    Text("Timetable")
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: const Border.fromBorderSide(BorderSide(width: 1)),



                    boxShadow: const [BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2
                    )]
                ),

                child: const Row(
                  children: [
                    Icon(
                      Icons.timelapse_rounded,
                      size: 28,
                    ),

                    Text("Recent")
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
