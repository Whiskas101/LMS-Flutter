
import 'package:dy_integrated_5/providers/TextControllerProvider.dart';
import 'package:dy_integrated_5/screens/Dashboard/Dashboard.dart';
import 'package:dy_integrated_5/services/api_service.dart';
import 'package:dy_integrated_5/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';





class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final refreshThrottler = Throttler();


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // This is a waste of resources, no need to initialise entire controllers
    // TODO: Switch to a simple [Provider<String>], instead of a heavy [Provider<TextEditingController>] 

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
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,


              children: [
                //Login form Box
                Column(
                  children: [
                    // Username field
                    TextField(
                      controller: usernameController,
                      cursorColor: Colors.blue,

                      decoration: const InputDecoration(

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

                    const SizedBox(height: 24,),

                    //Password field
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      cursorColor: Colors.blue,
                      decoration: const InputDecoration(
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

                const SizedBox(height: 24,),

                //Login button
                ElevatedButton(
                    onPressed: ()=>refreshThrottler.run((){
                      tryLogin();
                    }),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Colors.black87
                      )
                    )
                  ),
                    child: const Text(
                        "login",
                      style: TextStyle(
                        color: Colors.black87
                      ),
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
