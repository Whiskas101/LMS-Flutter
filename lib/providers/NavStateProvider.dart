/// For handling the state in navigation bars/rails

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavStateNotifier extends StateNotifier<int> {
  NavStateNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

final navStateProvider =
    StateNotifierProvider<NavStateNotifier, int>((ref) => NavStateNotifier());
