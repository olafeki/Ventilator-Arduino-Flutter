import 'package:flutter/material.dart';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';

class ModeWidget extends StatefulWidget {
  final Function(int) onChange;

  const ModeWidget({Key? key, required this.onChange}) : super(key: key);

  @override
  _ModeWidgetState createState() => _ModeWidgetState();
}

class _ModeWidgetState extends State<ModeWidget> {
  int _mode = 0;

  final ChoiceChip3DStyle selectedStyle = ChoiceChip3DStyle(
      topColor: Colors.grey[200]!,
      backColor: Colors.grey,
      borderRadius: BorderRadius.circular(20));

  final ChoiceChip3DStyle unselectedStyle = ChoiceChip3DStyle(
      topColor: Colors.white,
      backColor: Colors.grey[300]!,
      borderRadius: BorderRadius.circular(20));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Take up the entire width of the row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ChoiceChip3D(
              border: Border.all(color: Colors.grey),
              style: _mode == 1 ? selectedStyle : unselectedStyle,
              onSelected: () {
                setState(() {
                  _mode = 1;
                });
                widget.onChange(_mode);
              },
              onUnSelected: () {},
              selected: _mode == 1,
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      "lib/assets/images/data-entry.png",
                      fit: BoxFit.contain, // Fit the image within the container
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text("Mode 1")
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ChoiceChip3D(
              border: Border.all(color: Colors.grey),
              style: _mode == 2 ? selectedStyle : unselectedStyle,
              onSelected: () {
                setState(() {
                  _mode = 2;
                });
                widget.onChange(_mode);
              },
              selected: _mode == 2,
              onUnSelected: () {},
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      "lib/assets/images/pressure-icon.png",
                      fit: BoxFit.contain, // Fit the image within the container
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text("Mode 2")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}