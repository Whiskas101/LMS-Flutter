
import 'package:dy_integrated_5/screens/RecentsScreen/RecentsList.dart';
import 'package:dy_integrated_5/screens/RecentsScreen/RecentsSearchBar.dart';
import 'package:dy_integrated_5/screens/RecentsScreen/ScreenTitle.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RecentsScreen extends ConsumerWidget {
  const RecentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      body: Column(

        children: [
          Container(

            padding: const EdgeInsets.fromLTRB(8,  40, 8, 40),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
              color: Colors.lightBlue,
              boxShadow: [
                BoxShadow(
                  color: Colors.black87,
                  spreadRadius: -10,
                  blurRadius: 25
                )
              ]
            ),

            child: const Column(
              children: [
                SizedBox(
                  height: 24,
                ),

                //Screen Name
                ScreenTitle(),

                //SearchBar
                RecentsSearchBar()

              ],
            ),
          ),



          //Recent Material display
          Expanded(
              child: Container(
                  decoration: BoxDecoration(

                    gradient: LinearGradient(
                        colors: [
                          Colors.grey.shade100,
                          Colors.grey.shade50,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                    ),
                  ),

                  child: const RecentsList()
              )
          )
        ],
      ),
    );
  }
}
