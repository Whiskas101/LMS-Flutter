import 'package:dy_integrated_5/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showSnackBar(String text, int milliseconds) {
  snackbarKey.currentState?.showSnackBar(SnackBar(
    content: Text(text),
    // backgroundColor: Theme.of(context).colorScheme.primary,
    duration: Duration(milliseconds: milliseconds),
  ));
}
