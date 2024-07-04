import 'package:dy_integrated_5/screens/Dashboard/QuickJump.dart';
import 'package:dy_integrated_5/screens/Dashboard/SubjectGridSection.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'HeadSection.dart';
import 'TopBar.dart';



class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
             SizedBox(height: 24,),

              //Upper most layer, with the two buttons [ no functionality (YET) ]
              TopBar(),

              SizedBox(height: 24,),

              // Weird ahh message that makes no sense but autistic aesthetic
              HeadSection(),

              SizedBox(height: 28,),

              // QuickJump
              QuickJump(),


              SizedBox(height: 32,),

              //Subjects
              Expanded(
                  child: SubjectGridSection()
              )


            ],
          ),
        ),
      ),

    );
  }
}
