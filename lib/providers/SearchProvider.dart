import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends Notifier<String> {
  @override
  build() {
    return "";
  }

  void updateSearchTerm(String text) {
    state = text;
  }
}

final searchProvider =
    NotifierProvider<SearchNotifier, String>(() => SearchNotifier());
