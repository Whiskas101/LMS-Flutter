import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/screens/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/screens/SubjectScreen/SubjectScreen.dart';
import 'package:dy_integrated_5/screens/playground.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',

        theme: ThemeData(

          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.aBeeZeeTextTheme()
        ),
        home: SubjectScreen(),
      ),
    );
  }
}

