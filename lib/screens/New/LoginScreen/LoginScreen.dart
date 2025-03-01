import "package:dy_integrated_5/widgets/NeonText.dart";
import "package:flutter/material.dart";

class LoginScreenV2 extends StatelessWidget {
  const LoginScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Currently just dont allow keyboard to affect the scaffold size

      backgroundColor: const Color(0xff23242E),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            // Login Text
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0),
              // color: Colors.red,
              child: const Text(
                "LOGIN",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 84.0,
                  color: Color(0xFFFE8C52),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: const Size.fromHeight(82),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    // First input, for user email
                    Row(
                      children: [
                        Text(
                          "EMAIL (LMS)",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    // Wrapping the text field with a container
                    // because the API for styling it is horrendous
                    SizedBox.fromSize(
                      size: Size.fromHeight(14),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFf5A5969),
                      ),
                      child: const TextField(
                        autofocus: true,
                        autocorrect: false,
                        // cursorOpacityAnimates: true,
                        cursorWidth: 16,
                        cursorColor: Color(0xff23242E),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // Gap between two input sections
                    SizedBox.fromSize(size: const Size.fromHeight(45)),

                    // second input, for user password
                    const Row(
                      children: [
                        Text(
                          "PASSWORD",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    // Wrapping the text field with a container
                    // because the API for styling it is horrendous
                    SizedBox.fromSize(
                      size: Size.fromHeight(14),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xFf5A5969),
                      ),
                      child: const TextField(
                        autofocus: true,
                        autocorrect: false,
                        // cursorOpacityAnimates: true,
                        cursorWidth: 16,
                        cursorColor: Color(0xff23242E),
                        style: TextStyle(color: Color(0xff23242E)),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // Lil bit of space before the common defaults
                    SizedBox.fromSize(
                      size: const Size.fromHeight(18),
                    ),

                    // Common Defaults section

                    const Row(
                      children: [
                        Text(
                          "COMMON DEFAULTS",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff5A5969),
                          ),
                        ),
                      ],
                    ),

                    SizedBox.fromSize(
                      size: const Size.fromHeight(10),
                    ),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            border: Border.all(
                              color: Color(0xff5A5969),
                            ),
                          ),
                          child: const Text(
                            "Dypatil@123",
                            style: TextStyle(
                              color: Color(0xff5A5969),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // The final button
            Container(
              // padding: const EdgeInsets.symmetric(vertical: 25),
              margin: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 38,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: const Color(0xffFE8C52),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      // padding: const EdgeInsets.symmetric(vertical: 25),
                      color: const Color(0xffFE8C52),
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        overlayColor: WidgetStateColor.resolveWith(
                          (states) => Colors.red,
                        ),
                        onTap: () {
                          print("what");
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            // color: Colors.blue,
                            child: Icon(Icons.keyboard_arrow_right)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
