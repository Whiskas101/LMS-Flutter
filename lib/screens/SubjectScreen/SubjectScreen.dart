import 'package:dy_integrated_5/screens/SubjectScreen/BigSubjectCard.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/MaterialLists.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/ScreenTitle.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/SearchBar.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../../models/Subject.dart';

class SubjectScreen extends StatelessWidget {
  final Subject subject;

  const SubjectScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              // Screen Name + Refresh Button WITH Big Subject Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceVariant
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  // gradient: LinearGradient(colors: [
                  //   Colors.grey.shade100,
                  //   Colors.grey.shade50,
                  // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  // boxShadow: [
                  //   //top left shadow
                  //   BoxShadow(
                  //       color: Colors.grey.shade50,
                  //       offset: const Offset(-10, -10),
                  //       blurRadius: 15,
                  //       spreadRadius: 1),

                  //   //Bottom right shadow
                  //   BoxShadow(
                  //       color: Colors.grey.shade300,
                  //       offset: const Offset(15, 15),
                  //       blurRadius: 15,
                  //       spreadRadius: 14)
                  // ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15)),
                          border: Border(
                              bottom: BorderSide(
                                  width: 5,
                                  color:
                                      Theme.of(context).colorScheme.surface))),
                      child: ScreenTitle(subject: subject),
                    ),

                    // Top Most Card with the [Subject details]
                    BigSubjectCard(
                      subject: subject,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceVariant
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    // gradient: LinearGradient(colors: [
                    //   Colors.grey.shade100,
                    //   Colors.grey.shade50,
                    // ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    // boxShadow: [
                    //   //top left shadow
                    //   BoxShadow(
                    //       color: Colors.grey.shade50,
                    //       offset: const Offset(-10, -10),
                    //       blurRadius: 15,
                    //       spreadRadius: 1),

                    //   //Bottom right shadow
                    //   BoxShadow(
                    //       color: Colors.grey.shade300,
                    //       offset: const Offset(15, 15),
                    //       blurRadius: 15,
                    //       spreadRadius: 14)
                    // ],
                  ),
                  child: Column(
                    children: [
                      //Search Function
                      const CustomSearchBar(),

                      //Actual resources
                      Expanded(child: MaterialLists(subject: subject))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
