import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:try1/components/already_have_an_account_acheck.dart';
import 'package:try1/constants.dart';
import 'package:try1/Signup/signup_screen.dart';

class LoginForm extends StatelessWidget {
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
                  Navigator.pushNamed(context, "/welcome_screen");
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
    return Form(
      child: Column(
        children: [
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
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                signInUser(context);
              },
              child: Text(
                'Log In',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 79, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );

  }
}