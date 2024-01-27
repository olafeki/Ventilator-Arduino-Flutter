import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signInUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushNamed(context, "/home");
    } catch (e) {
      String errorMessage = "Invalid email or password";
      print(errorMessage);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign-in Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pushNamed(context, "/account");
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Wrap with SingleChildScrollView
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
                      SizedBox(height: 35),
                      Text(
                        "Log In",
                        style: TextStyle(fontSize: 33),
                      ),
                      SizedBox(height: 35),
                      Image.asset(
                        "lib/assets/images/blulogin.png",
                        width: 288,
                      ),
                      SizedBox(height: 35),
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
                            icon: Icon(
                              Icons.person,
                              color: Colors.blue[800],
                              size: 19,
                            ),
                            hintText: "Email",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
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
                            suffix: Icon(
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
                      SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: () {
                          signInUser(context);
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 79, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(27),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
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