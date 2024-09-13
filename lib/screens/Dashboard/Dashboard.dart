import 'package:dy_integrated_5/screens/Dashboard/QuickJump.dart';
import 'package:dy_integrated_5/screens/Dashboard/SubjectGridSection.dart';
import 'package:dy_integrated_5/utils/constants.dart';
import 'package:dy_integrated_5/widgets/LimitWidth.dart';

import 'package:flutter/material.dart';

import 'HeadSection.dart';
import 'TopBar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 28),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16)),
                border: BorderDirectional(
                    bottom: BorderSide(
                        width: 7,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5))),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),

                  //Upper most layer, with the two buttons
                  TopBar(),

                  const SizedBox(
                    height: 18,
                  ),

                  // Weird ahh message that makes no sense but yes
                  const HeadSection(),
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
                  const QuickJump(),

                  const SizedBox(
                    height: 16,
                  ),

                  //Subjects
                  Expanded(child: SubjectGridSection()),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
    );
  }
}
