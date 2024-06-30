import 'package:dy_integrated_5/screens/Dashboard/QuickJump.dart';
import 'package:dy_integrated_5/screens/Dashboard/SubjectGridSection.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:flutter/material.dart';

import 'HeadSection.dart';
import 'TopBar.dart';



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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
             const SizedBox(height: 24,),
              
              //Upper most layer, with the two buttons [ no functionality (YET) ]
              TopBar(),

              const SizedBox(height: 24,),

              // Weird ahh message that makes no sense but autistic aesthetic
              HeadSection(),

              const SizedBox(height: 28,),

              // QuickJump
              const QuickJump(),


              const SizedBox(height: 32,),

              //Subjects
              SubjectGridSection()


            ],
          ),
        ),
      ),

    );
  }
}
