import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import 'package:try1/screens/Login/login_screen.dart';

class SignUpForm extends StatelessWidget {
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
          ElevatedButton(
            onPressed: () {
              signUpUser(context);
            },
            child: Text("Sign Up".toUpperCase(),
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
              )
            ),

          ),
          const SizedBox(height: defaultPadding),
          // Display error message
          Text(
            errorController.text,
            style: TextStyle(color: Colors.red),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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