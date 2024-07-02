
import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Recents.dart';


// class RecentsNotifer extends AsyncNotifier<Recents>{
//   @override
//   FutureOr<Recents> build() async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = await prefs.getString("recents");
//     if(data == null) return Recents(); // Empty list of materials if not used prior
//     return Recents.fromJSON(jsonDecode(data));
//   }
//
// }