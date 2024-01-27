import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:try1/screens/home.dart';
import 'package:try1/screens/login.dart';
import 'package:try1/screens/signup.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // User is logged in, navigate to home page
            return HomePage();
          } else {
            // User is not logged in
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Text('Log In'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Text('Sign Up'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}