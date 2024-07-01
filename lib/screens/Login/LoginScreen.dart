
import 'package:dy_integrated_5/providers/TextControllerProvider.dart';
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

    final usernameController = ref.watch(usernameControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

    
    void tryLogin()async{
      print(usernameController.text);
      print(passwordController.text);
      final nav = Navigator.of(context);
      bool result = await ApiService.attemptLogin(
          usernameController.text,
          passwordController.text
      );

      if(result == true){
        nav.pushReplacement(
          MaterialPageRoute(builder: (context)=>const Dashboard())
        );
      }
    }





    return Scaffold(

      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,


              children: [
                //Login Box
                Container(
                  // color: Colors.red,

                  child: Column(
                    children: [
                      // Username field
                      TextField(
                        controller: usernameController,
                        cursorColor: Colors.blue,

                        decoration: InputDecoration(

                          labelText: "Username",
                          labelStyle: TextStyle(
                            color: Colors.blueGrey
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blueAccent
                            )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black87
                              )
                          )

                        ),
                      ),

                      SizedBox(height: 24,),

                      //Password field
                      TextField(
                        obscureText: true,
                        controller: passwordController,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: Colors.blueGrey
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black87
                                )
                            )

                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24,),

                //Login button
                ElevatedButton(
                    onPressed: tryLogin,
                    child: Text(
                        "login",
                      style: TextStyle(
                        color: Colors.black87
                      ),
                    ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Colors.black87
                      )
                    )
                  )
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
