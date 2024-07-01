import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';




final usernameControllerProvider = Provider<TextEditingController>((ref){
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;

});

final passwordControllerProvider = Provider<TextEditingController>((ref){
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});