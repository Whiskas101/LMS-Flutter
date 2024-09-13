import 'package:dy_integrated_5/providers/SearchProvider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomSearchBar extends ConsumerWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          border: Border(
              bottom: BorderSide(
                  width: 5, color: Theme.of(context).colorScheme.surface))
          // border: Border.fromBorderSide(
          //   BorderSide(width: 1, color: CustomColors.customGray),
          // ),
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Search Icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

          //Search field
          Flexible(
            child: TextField(
              onChanged: (value) =>
                  ref.watch(searchProvider.notifier).updateSearchTerm(value),
              decoration: null,
            ),
          ),

          //Weird end logo
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
          //   child: IconButton(
          //       onPressed: (){
          //         ref.read(searchProvider.notifier).updateSearchTerm("");
          //       },
          //       icon:  const Icon(Icons.remove_circle)
          //   ),
          // ),
        ],
      ),
    );
  }
}
