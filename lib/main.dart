import 'package:dy_integrated_5/screens/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/screens/Login/LoginScreen.dart';
import 'package:dy_integrated_5/screens/playground.dart';
import 'package:dy_integrated_5/utils/globals.dart';

import 'package:dy_integrated_5/services/api_service.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // for windows machines that dont use sqflite meant for mobile devices
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  Map<String, String?> user = await ApiService.getCredentials();
  if ((user['username'] != null && user['password'] != null)) {
    runApp(const MyApp(home: Dashboard()));
  } else {
    runApp(MyApp(home: LoginScreen()));
  }
  // runApp(MyApp(home: Playground()));
}

class MyApp extends StatelessWidget {
  final Widget home;
  const MyApp({super.key, required this.home});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'FDY',
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData(
            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: GoogleFonts.aBeeZeeTextTheme()),
        home: home,
      ),
    );
  }
}
