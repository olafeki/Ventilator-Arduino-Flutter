import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController errorController = TextEditingController();

  void signUpUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // User successfully signed up, navigate to home page
      Navigator.pushNamed(context, "/home");
    } catch (e) {
      String errorMessage = "Sign-up error: $e";
      errorController.text = errorMessage;
      print(errorMessage);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign-up Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Container(
            height: MediaQuery.of(context).size.height, // Use available height
            color: Colors.white,
            width: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Adjust the alignment
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 33),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Image.asset(
                        "lib/assets/images/blusignup.jpg",
                        width: 240,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.person,
                              color: Colors.blue[800],
                              size: 19,
                            ),
                            hintText: "Email",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility,
                              color: Colors.blue[900],
                            ),
                            icon: Icon(
                              Icons.lock,
                              color: Colors.blue[800],
                              size: 19,
                            ),
                            hintText: "Password",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          signUpUser(context);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 79, vertical: 10),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Image.asset(
                    "lib/assets/images/main_top.png",
                    width: 111,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "lib/assets/images/login_bottom.png",
                    width: 111,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}