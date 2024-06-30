import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/constants.dart';

class ScreenTitle extends StatefulWidget {
  const ScreenTitle({super.key});

  @override
  State<ScreenTitle> createState() => _ScreenTitleState();
}

class _ScreenTitleState extends State<ScreenTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        //Leading Icon
        Icon(
          Icons.book,
          size: 32,

        ),

        // Screen Name [course material]
        Expanded(
          child: Text(
            "Course Material",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

        //Refresh Button
        Padding(
          padding: const EdgeInsets.fromLTRB(0,0,8,0),
          child: IconButton(
            icon:Icon(
              Icons.refresh_sharp,
              size: 32,
            ),
            onPressed: (){},

          ),
        ),


      ],
    );
  }
}
