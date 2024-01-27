import 'package:flutter/material.dart';
import 'package:try1/colors.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  pcolor.withOpacity(0.8),
                  pcolor,
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image.asset("lib/assets/images/doctor5.png"),
                ),
                SizedBox(height: 50),
                Text(
                  "Sensors Online",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    wordSpacing: 2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Keep track of your health",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 60),
                Material(
                  color: wcolor,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/welcome_screen");
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
                        "Let's Go",
                        style: TextStyle(
                          color: pcolor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Image.asset(
                  "lib/assets/images/heart.png",
                  color: wcolor,
                  scale: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}