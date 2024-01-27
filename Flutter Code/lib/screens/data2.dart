import 'package:flutter/material.dart';
import 'package:try1/pressure_widget.dart';

class Data2 extends StatelessWidget {
  const Data2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          color: Colors.white,
          width: double.infinity,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Image.asset(
                      "lib/assets/images/ambu_pic.png",
                      width: 200,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Enter the pressure",
                      style: TextStyle(fontSize: 33),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    PressureWidget(
                        onChange: (pressure){

                        }),
                  ], // Added closing bracket for Column widget
                ), // Added closing bracket for SizedBox widget
              ),
              Positioned(
                left: 0,
                child: Image.asset(
                  "lib/assets/images/main_top.png",
                  width: 100,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "lib/assets/images/main_bottom.png",
                  width:100,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/");
                  },
                  child: Image.asset(
                    "lib/assets/images/button.png",
                    width: 80,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}