import 'package:dy_integrated_5/providers/ApiServiceProvider.dart';
import 'package:dy_integrated_5/providers/ThemeProvider.dart';
import 'package:dy_integrated_5/screens/AttendanceScreen/AttendanceScreen.dart';
import 'package:dy_integrated_5/screens/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/screens/Login/LoginScreen.dart';
import 'package:dy_integrated_5/screens/playground.dart';
import 'package:dy_integrated_5/themes/themes.dart';
import 'package:dy_integrated_5/utils/globals.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  runApp(const ProviderScope(child: MyApp(home: AuthCheck())));

  // runApp(MyApp(home: AttendanceScreen()));

  // runApp(ProviderScope(
  //   child: MyApp(home: Playground()),
  // ));
}

// Just to implement automatic login, and handling the case of first-time opening of the application

class AuthCheck extends ConsumerWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creds = ref.watch(credentialProvider);

    return creds.when(
        data: (user) {
          if ((user['username'] != null && user['password'] != null)) {
            return const Dashboard();
          } else {
            return LoginScreen();
          }
        },
        error: (error, stackTrace) =>
            const Text("Something Went HORRIBLY Wrong."),
        loading: () => const CircularProgressIndicator());
  }
}

class MyApp extends ConsumerWidget {
  final Widget home;
  const MyApp({super.key, required this.home});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final theme = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'FDY',
      scaffoldMessengerKey: snackbarKey,
      navigatorKey: navigatorKey,
      theme: darkTheme,
      themeMode: ThemeMode.system,
      home: home,
    );
  }
}
