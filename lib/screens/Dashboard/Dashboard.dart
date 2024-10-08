import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/screens/Dashboard/QuickJump.dart';
import 'package:dy_integrated_5/screens/Dashboard/SubjectGridSection.dart';
import 'package:dy_integrated_5/widgets/SideBar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'HeadSection.dart';
import 'TopBar.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Column(
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

        /// BORDER FOR INDICATING REFRESH
        /// Making animations is boring.

        IgnorePointer(
          child: Consumer(builder: (context, ref, child) {
            final semester = ref.watch(semesterNotifierProvider);

            return AnimatedContainer(
              curve: Curves.easeInOutQuint,
              duration: const Duration(milliseconds: 1000),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                      width: semester.isRefreshing ? 25 : 0,
                      color: semester.isRefreshing
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8)
                          : Colors.transparent),
                ),
              ),
            );
          }),
        )
      ]),
    );
  }
}
