import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/constants.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.search),
          ),
          Flexible(
            child: TextField(
              decoration: null,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(Icons.keyboard_option_key),
          ),
        ],
      ),
    );
  }
}
