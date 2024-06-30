

import 'package:dy_integrated_5/screens/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/screens/Login/LoginScreen.dart';
import 'package:dy_integrated_5/services/api_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Map<String, String?> user = await ApiService.getCredentials();
  if((user['username'] != null && user['password'] != null)){
    runApp(MyApp(home:Dashboard()));
  }else{
    runApp(MyApp(home: LoginScreen()));
  }


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

        theme: ThemeData(

          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.aBeeZeeTextTheme()
        ),
        home: Dashboard(),
      ),
    );
  }
}

