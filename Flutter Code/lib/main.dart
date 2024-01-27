import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:try1/screens/sensor_screen.dart';
import 'Welcome/welcome_screen.dart';
import 'auth_page.dart';
import 'firebase_options.dart';
import 'package:try1/screens/account.dart';
import 'package:try1/screens/home.dart';
import 'package:try1/screens/welcome.dart';
import 'package:try1/screens/data.dart';
import 'package:try1/screens/data2.dart';
import 'package:try1/screens/login.dart';
import 'package:try1/screens/signup.dart';
import 'package:try1/auth_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/" : (context) => const Welcome(),
        "/data" : (context) => const Data(),
        "/data2" : (context) => const Data2(),
        "/account" : (context) => const Account(),
        "/login" : (context) => Login(),
        "/signup" : (context) =>  Signup(),
        "/home" : (context) => const HomePage(),
        "/auth_page" : (context) => AuthPage(),
        "/snsor_screen": (context) => FetchData(),
        '/welcome_screen': (context) => WelcomeScreen(),
      },
    );
  }
}
