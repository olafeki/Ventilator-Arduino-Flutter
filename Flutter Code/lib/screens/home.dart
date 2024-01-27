import 'package:flutter/material.dart';
import 'package:try1/colors.dart';
import 'package:try1/mode_widget.dart';
import 'package:try1/screens/bim_screen.dart';
import 'package:try1/screens/data.dart';
import 'package:try1/screens/data2.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    void navigateToDataPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Data()),
      );
    }

    void navigateToData1Page() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BMIScreen()),
      );
    }

    return Material(
      color: Color(0xffd9e4ee),
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      pcolor.withOpacity(0.8),
                      pcolor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                AssetImage("lib/assets/images/doc.png"),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Hi Patient,",
                            style: TextStyle(
                              color: wcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Your health is our\n first priority",
                            style: TextStyle(
                              color: wcolor,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15, bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: wcolor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: bcolor,
                                  blurRadius: 6,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              readOnly: true, // Set readOnly property to true
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Choose one of the 2 modes",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                prefixIcon: Icon(
                                  Icons.arrow_right_alt,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          ModeWidget(
                            onChange: (mode) {
                              if (mode == 1) {
                                navigateToDataPage();
                              } else if (mode == 2) {
                                navigateToData1Page();
                              }
                            },
                          ),
                          SizedBox(height: 20),

                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.only(top: 15, bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Mode 1: Start Ventilator",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                prefixIcon: Icon(
                                  Icons.check_circle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.only(top: 15, bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Mode 2: BIM Calculator",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                prefixIcon: Icon(
                                  Icons.check_circle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.only(top: 15, bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Keep track of your health :)",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                prefixIcon: Icon(
                                  Icons.check_circle,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            margin: EdgeInsets.only(top: 15, bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Contact us for any problem",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                prefixIcon: Icon(
                                  Icons.tag_faces,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}