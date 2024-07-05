import 'package:dy_integrated_5/screens/Dashboard/QuickJump.dart';
import 'package:dy_integrated_5/screens/Dashboard/SubjectGridSection.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'HeadSection.dart';
import 'TopBar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 28),
              decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(16)),

                boxShadow: [BoxShadow(
                  color: CustomColors.customDarkGrey3,
                  blurRadius: 3
                )]
              ),
              child: const Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),

                  //Upper most layer, with the two buttons [ no functionality (YET) ]
                  TopBar(),

                  SizedBox(
                    height: 18,
                  ),

                  // Weird ahh message that makes no sense but autistic aesthetic
                  HeadSection(),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Expanded(
              child: Column(
                children: [
                  // QuickJump
                  QuickJump(),

                  SizedBox(
                    height: 16,
                  ),

                  //Subjects
                  SubjectGridSection()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
