
import 'package:flutter/material.dart';
import 'package:dy_integrated_5/utils/constants.dart';

class MaterialLists extends StatefulWidget {
  const MaterialLists({super.key});

  @override
  State<MaterialLists> createState() => _MaterialListsState();
}

class _MaterialListsState extends State<MaterialLists> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 20),
      height: 450,

      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black87,
                  width: 1,


                ),
                boxShadow: [BoxShadow(
                  color: CustomColors.customGray,
                  blurRadius: 5,
                )]
            ),
            child: ListTile(
              leading: Icon(
                Icons.document_scanner,
                size: 32,
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Wish I had more time to work on this crap",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),//File name
              subtitle: Text("pdf"),
              trailing: Icon(
                  Icons.refresh_sharp
              ),



            ),
          ),

        ],
      ),
    );
  }
}
