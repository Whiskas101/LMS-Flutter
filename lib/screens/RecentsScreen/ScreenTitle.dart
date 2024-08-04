import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.exit_to_app,
              size: 32,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "Recently Opened",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 26,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
