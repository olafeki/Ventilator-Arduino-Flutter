import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:try1/screens/HeartRate_Sensor.dart';


import 'package:try1/screens/home.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);
  @override
  State<Info> createState() => _FetchDataState();
}

class _FetchDataState extends State<Info> {
  late Query dbRef;
  DatabaseReference reference = FirebaseDatabase.instance
      .reference()
      .child('UsersData')
      .child('ypAYpocznPhMKmAX5n6DEPyzIs32')
      .child('information');

  Widget listItem({required Map data, required String key}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff0c84ff),
              width: 2,
            ),
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFBBDEFB)],
            ),
            borderRadius: BorderRadius.circular(10),
            //color: Colors.white,
          ),
          child: Column(
            children: [
              Image.asset(
                'lib/assets/images/age-range_7187696.png',
                //color: Colors.white,
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Age',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${data['age']} Years',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff0c84ff),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),


        // Add similar containers for other sensor readings
        // gender
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff0c84ff),
              width: 2,
            ),
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFBBDEFB)],
            ),
            borderRadius: BorderRadius.circular(10),
            //color: Colors.white,
          ),
          child: Column(
            children: [
              Image.asset(
                'lib/assets/images/lavatory_1647794.png',
                //color: Colors.white,
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  //Column
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${data['gender']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff0c84ff),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Weight
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff0c84ff),
              width: 2,
            ),
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFBBDEFB)],
            ),
            borderRadius: BorderRadius.circular(10),
            //color: Colors.white,
          ),
          child: Column(
            children: [
              Image.asset(
                'lib/assets/images/weight.png',
                //color: Colors.white,
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weight',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${data['weight']} Kg',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff0c84ff),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Height
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff0c84ff),
              width: 2,
            ),
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFBBDEFB)],
            ),
            borderRadius: BorderRadius.circular(10),
            //color: Colors.white,
          ),
          child: Column(
            children: [
              Image.asset(
                'lib/assets/images/height.png',
                //color: Colors.white,
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Height',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${data['height']} m',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff0c84ff),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    String loggedInUserId = FirebaseAuth.instance.currentUser!.uid;
    reference = FirebaseDatabase.instance
        .reference()
        .child('data')
        .child(loggedInUserId);

    dbRef = reference.orderByChild('timestamp').limitToLast(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SUMMARY',
          style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent, // Purple color
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white, // Purple color
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: reference,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map data = snapshot.value as Map;
                  String key = snapshot.key!;
                  return listItem(data: data, key: key);
                },
              ),
            ),
            ElevatedButton(
              onPressed: _navigateToAnotherScreen,
              child: Text('Check Your Heart'),

            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAnotherScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HeartRate()),
    );
  }
}