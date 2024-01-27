import 'package:flutter/material.dart';
import 'package:try1/gender_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:try1/screens/sensor_screen.dart';

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  final TextEditingController age = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController breathRate = TextEditingController();
  final DatabaseReference dbRef1 =
  FirebaseDatabase.instance.reference().child("data");
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference dbRef2 =
  FirebaseDatabase.instance.reference().child("bmp");

  int selectedGender = 0; // 0 for male, 1 for female

  void saveUserData() async {
    User? user = auth.currentUser;
    if (user != null) {
      String userId = user.uid;
      print('User ID: $userId');

      DateTime now = DateTime.now();
      String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      int timestamp1 = now.millisecondsSinceEpoch ~/ 1000;

      DatabaseReference userRef = dbRef1.child(userId).child(timestamp);
      DatabaseReference userRef2 = dbRef2.child(timestamp1.toString());

      userRef.set({
        'age': age.text,
        'height': height.text,
        'weight': weight.text,
        //'breathRate': breathRate.text,
        'gender': selectedGender == 0 ? 'Male' : 'Female',  //ternary conditional operator
        'timestamp': timestamp,
      });
      userRef2.set({
        'breathRate': breathRate.text,
        'timestamp': timestamp1,
      });


      age.clear();
      height.clear();
      weight.clear();
      breathRate.clear();
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    age.dispose();
    height.dispose();
    weight.dispose();
    breathRate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            width: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 55,
                      ),
                      Text(
                        "Enter your Data",
                        style: TextStyle(fontSize: 33),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Image.asset(
                        "lib/assets/images/ambu_pic.png",
                        width: 100,
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
                          controller: age,
                          decoration: InputDecoration(
                            hintText: "Enter your age",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: height,
                          decoration: InputDecoration(
                            hintText: "Enter your height",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: weight,
                          decoration: InputDecoration(
                            hintText: "Enter your weight",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 266,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: breathRate,
                          decoration: InputDecoration(
                            hintText: "Enter breath rate per minute",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GenderWidget(
                        // Handle the gender change here
                        onChange: (gender) {
                          setState(() {
                            selectedGender = gender;
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
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
                    width: 100,
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      saveUserData();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FetchData()),
                      );
                    },
                    child: Image.asset(
                      "lib/assets/images/blubutton.png",
                      width: 80,
                    ),
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