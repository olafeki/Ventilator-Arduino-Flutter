import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "WELCOME",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: Image.asset( "lib/assets/images/comp1.png", height: 350,),
              ),
            Spacer(),
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}