import 'package:dy_integrated_5/utils/globals.dart';
import 'package:flutter/material.dart';


void showSnackBar(String text, int milliseconds){

  snackbarKey.currentState?.showSnackBar(
     SnackBar(
         content: Text(text),
       backgroundColor: Colors.lightBlueAccent,
       duration: Duration(milliseconds: milliseconds),
     )
  );
}