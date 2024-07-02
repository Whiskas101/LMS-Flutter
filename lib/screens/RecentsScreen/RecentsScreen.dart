import 'package:dy_integrated_5/providers/SearchProvider.dart';
import 'package:dy_integrated_5/screens/RecentsScreen/RecentsList.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/constants.dart';

class RecentsScreen extends ConsumerWidget {
  const RecentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),

              //Screen Name
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Recently Opened",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              //SearchBar
              Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.fromBorderSide(
                      BorderSide(width: 1, color: CustomColors.customGray),
                    ),
                    boxShadow: [
                      BoxShadow(color: CustomColors.customGray, blurRadius: 1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Search Icon
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(Icons.search),
                    ),

                    //Search field
                    Flexible(
                      child: TextField(
                        onChanged: (value) => ref
                            .watch(searchProvider.notifier)
                            .updateSearchTerm(value),
                        decoration: null,
                      ),
                    ),

                    //Weird end logo
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: IconButton(
                          onPressed: () {
                            ref
                                .read(searchProvider.notifier)
                                .updateSearchTerm("");
                          },
                          icon: const Icon(Icons.remove_circle)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32,),

              //Recent Material display
              RecentsList()
            ],
          ),
        ),
      ),
    );
  }
}
