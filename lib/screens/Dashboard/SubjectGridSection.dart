import 'package:flutter/material.dart';

import 'package:dy_integrated_5/utils/constants.dart';


class SubjectGridSection extends StatelessWidget {
  const SubjectGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Your Courses",
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14,),

        //Subject Grid
        SizedBox(
          height: 350,

          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.7/1,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),


            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: const Border.fromBorderSide(BorderSide(width: 1)),
                    boxShadow: [BoxShadow(
                        color: CustomColors.customGray,
                        blurRadius: 2
                    )]
                ),

                child: const Column(
                  children: [
                    Row(

                      children: [
                        Text("Course Name"),

                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Faculty Name",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey
                          ),

                        )
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("71%")
                        ],
                      ),
                    )
                  ],
                ),


              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: const Border.fromBorderSide(BorderSide(width: 1)),
                    boxShadow: [BoxShadow(
                        color: CustomColors.customGray,
                        blurRadius: 2
                    )]
                ),

                child: const Column(
                  children: [
                    Row(

                      children: [
                        Text("Course Name"),

                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Faculty Name",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey
                          ),

                        )
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("71%")
                        ],
                      ),
                    )
                  ],
                ),


              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: const Border.fromBorderSide(BorderSide(width: 1)),
                    boxShadow: [BoxShadow(
                        color: CustomColors.customGray,
                        blurRadius: 2
                    )]
                ),

                child: const Column(
                  children: [
                    Row(

                      children: [
                        Text("Course Name"),

                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Faculty Name",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey
                          ),

                        )
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("71%")
                        ],
                      ),
                    )
                  ],
                ),


              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: const Border.fromBorderSide(BorderSide(width: 1)),
                    boxShadow: [BoxShadow(
                        color: CustomColors.customGray,
                        blurRadius: 2
                    )]
                ),

                child: const Column(
                  children: [
                    Row(

                      children: [
                        Text("Course Name"),

                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Faculty Name",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey
                          ),

                        )
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("71%")
                        ],
                      ),
                    )
                  ],
                ),


              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: const Border.fromBorderSide(BorderSide(width: 1)),
                    boxShadow: [BoxShadow(
                        color: CustomColors.customGray,
                        blurRadius: 2
                    )]
                ),

                child: const Column(
                  children: [
                    Row(

                      children: [
                        Text("Course Name"),

                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Faculty Name",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey
                          ),

                        )
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("71%")
                        ],
                      ),
                    )
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
