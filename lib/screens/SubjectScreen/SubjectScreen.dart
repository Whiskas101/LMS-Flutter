
import 'package:dy_integrated_5/screens/SubjectScreen/BigSubjectCard.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/MaterialLists.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/ScreenTitle.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/SearchBar.dart';

import 'package:flutter/material.dart';

import '../../models/Subject.dart';





class SubjectScreen extends StatefulWidget {
  late Subject subject;

  SubjectScreen({super.key, required this.subject});

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
                const SizedBox(height: 20,),

                // Screen Name + Refresh Button
                ScreenTitle(subject: widget.subject),



                // Top Most Card with the [Subject details]
                BigSubjectCard(subject: widget.subject,),




                //Search Function
                CustomSearchBar(),



                //Actual resources
                MaterialLists(subject: widget.subject)



              ],
            ),
          ),
        )
    );
  }
}
