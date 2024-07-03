import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';



/// THESE ARE A BAD BAD IDEA.
/// NEED TO REPLACE THEM WITH SIMPLER EQUIVALENTS, OR USE [StatefulConsumerWidgets]


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

