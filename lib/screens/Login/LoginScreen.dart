import 'package:dy_integrated_5/providers/SemesterProvider.dart';
import 'package:dy_integrated_5/screens/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';





class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {


    // Things to work on!
    // Login screen
    // Find a way to fix the cant re read downloaded file issue for course materials












    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text("this the login page"),
        ),
      ),
    );
  }
}
