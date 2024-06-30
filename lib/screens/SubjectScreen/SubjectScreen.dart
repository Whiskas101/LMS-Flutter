
import 'package:dy_integrated_5/screens/SubjectScreen/BigSubjectCard.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/MaterialLists.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/ScreenTitle.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/SearchBar.dart';

import 'package:flutter/material.dart';





class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(

              children: [
                SizedBox(height: 20,),

                // Screen Name + Refresh Button
                ScreenTitle(),



                // Top Most Card with the [Subject details]
                BigSubjectCard(),




                //Search Function
                CustomSearchBar(),



                //Actual resources
                MaterialLists()



              ],
            ),
          ),
        )
    );
  }
}
