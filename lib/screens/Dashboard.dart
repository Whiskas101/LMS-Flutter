import 'package:dy_integrated_5/utils/constants.dart';
import 'package:flutter/material.dart';



class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
             SizedBox(height: 24,),
              
              //Upper most layer, with the two buttons, maybe add a search bar here?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                        Icons.line_style_sharp,
                      size: 32,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.refresh,
                      size: 32,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24,),

              // Weird ahh message that makes no sense but autistic aesthetic
              Row(

                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "DYF",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                        ),
                        Text(
                          "A Flutter App",
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

              SizedBox(height: 20,),

              //Search bar
              Container(
                height: 55,
                margin: EdgeInsets.symmetric(horizontal: 8.0),

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
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(
                          Icons.keyboard_option_key
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28,),

              // QuickJump
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                        "Quick Jump",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14,),

              //Quick Jump Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(

                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.fromBorderSide(BorderSide(width: 1)),



                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2
                        )]
                      ),

                      child: Row(
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
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.fromBorderSide(BorderSide(width: 1)),



                          boxShadow: [BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2
                          )]
                      ),

                      child: Row(
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

              SizedBox(height: 32,),

              //Subjects
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "Your Courses",
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14,),

              //Subject Grid
              Container(
                height: 350,

                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      childAspectRatio: 1.7/1
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),


                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, 
                          border: Border.fromBorderSide(BorderSide(width: 1)),
                          boxShadow: [BoxShadow(
                            color: CustomColors.customGray,
                            blurRadius: 2
                          )]
                        ),
                        
                        child: Column(
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
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.fromBorderSide(BorderSide(width: 1)),
                            boxShadow: [BoxShadow(
                                color: CustomColors.customGray,
                                blurRadius: 2
                            )]
                        ),

                        child: Column(
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
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.fromBorderSide(BorderSide(width: 1)),
                            boxShadow: [BoxShadow(
                                color: CustomColors.customGray,
                                blurRadius: 2
                            )]
                        ),

                        child: Column(
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
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.fromBorderSide(BorderSide(width: 1)),
                            boxShadow: [BoxShadow(
                                color: CustomColors.customGray,
                                blurRadius: 2
                            )]
                        ),

                        child: Column(
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
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.fromBorderSide(BorderSide(width: 1)),
                            boxShadow: [BoxShadow(
                                color: CustomColors.customGray,
                                blurRadius: 2
                            )]
                        ),

                        child: Column(
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
          ),
        ),
      ),

    );
  }
}
