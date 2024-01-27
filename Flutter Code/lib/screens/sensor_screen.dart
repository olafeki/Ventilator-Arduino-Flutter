import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:try1/screens/info.dart';
import 'HeartRate_Sensor.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);
  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  late Query dbRef;
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('SensorData');

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
                'lib/assets/images/gauge.png',
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
                    'Pressure',
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
                    '${data['pressure']} Pascal',
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
        // Temperature
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
                'lib/assets/images/temp1.png',
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
                    'Temperature',
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
                    '${data['temperature']}C',
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
// Humidity
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
                'lib/assets/images/trans-fat_8515586.png',
                //color: Colors.white,
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Humidity',
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
                    '${data['humidity']} C',
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

        // Heart Rate
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
                'lib/assets/images/heartrate.png',
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
                    'Heart Rate',
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
                    '${data['HeartRate']} BPM',
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
    dbRef = reference;
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
                query: dbRef,
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
              child: Text('Additional Data'),

            ),
          ],
        ),
      ),
    );
  }
  void _navigateToAnotherScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Info()),
    );
  }
}