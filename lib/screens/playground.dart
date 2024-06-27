import 'package:dy_integrated_5/services/api_service.dart';
import 'package:flutter/material.dart';


class Playground extends StatefulWidget {
  const Playground({super.key});

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {

  void doStuff(){
    ApiService.attemptLogin(
      'vik.cha.rt22@dypatil.edu',
      'dypatil@123'
    );
  }

  void doGetSubject(){
    ApiService.getSubjectData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                child: ElevatedButton(
                  onPressed: doStuff,
                  child: Text("do stuff"),
                ),
              ),
              ElevatedButton(
                onPressed: doGetSubject,
                child: Text("do subject stuff"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
