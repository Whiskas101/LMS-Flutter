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
  
  void doMaterialStuff(){
    // https://mydy.dypatil.edu/rait/course/view.php?id=5923
    // https://mydy.dypatil.edu/rait/course/view.php?id=5921
    // https://mydy.dypatil.edu/rait/course/view.php?id=5922,
    ApiService.getSubjectMaterial("https://mydy.dypatil.edu/rait/course/view.php?id=5921");
  }
  
  void doDownloadStuff(){
    // https://mydy.dypatil.edu/rait/mod/presentation/view.php?id=611990
    // https://mydy.dypatil.edu/rait/mod/presentation/view.php?id=612128
    // https://mydy.dypatil.edu/rait/mod/flexpaper/view.php?id=613117
    // https://mydy.dypatil.edu/rait/mod/presentation/view.php?id=614269

    ApiService.downloadResource("https://mydy.dypatil.edu/rait/mod/presentation/view.php?id=611990");
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
              ElevatedButton(
                onPressed: doMaterialStuff,
                child: Text("do material stuff"),
              ),
              ElevatedButton(
                onPressed: doDownloadStuff,
                child: Text("do download stuff"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
