import 'package:flutter/material.dart';

class PressureWidget extends StatefulWidget {
  final Function(int) onChange;

  const PressureWidget({Key? key, required this.onChange}) : super(key: key);

  @override
  _PressureWidgetState createState() => _PressureWidgetState();
}

class _PressureWidgetState extends State<PressureWidget> {
  int _pressure = 150;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 12,
        shape: const RoundedRectangleBorder(),
        child: Column(
          children: [
            const Text(
              "Pressure",
              style: TextStyle(fontSize: 25, color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _pressure.toString(),
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Pa",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )
              ],
            ),
            Slider(
              min: 0,
              max: 240,
              value: _pressure.toDouble(),
              thumbColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  _pressure = value.toInt();
                });
                widget.onChange(_pressure);
              },
            ),
          ],
        ),
      ),
    );
  }
}