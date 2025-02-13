import 'package:dy_integrated_5/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showSnackBar(String text, int milliseconds) {
  final context = snackbarKey.currentContext;
  if (context != null) {
    final snackBar = SnackBar(
      // backgroundColor:
      //     Theme.of(context).colorScheme.primary, // Always fetch latest theme
      content: Text(
        text,
        // style: TextStyle(
        //   color: Theme.of(context).colorScheme.onPrimary,
        // ),
      ),
      duration: Duration(milliseconds: milliseconds),
    );

    snackbarKey.currentState?.showSnackBar(snackBar);
  }
}
