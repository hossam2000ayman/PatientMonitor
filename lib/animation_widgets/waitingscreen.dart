
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';

class Waiting extends StatelessWidget {
  const Waiting({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: AnimatedTextKit(
         repeatForever: true,
            animatedTexts: [
            RotateAnimatedText('Please Wait',textStyle: TextStyle(color: Colors.black,fontSize: 32)),
            RotateAnimatedText('Tap on Scan Button',textStyle: TextStyle(color: Colors.black,fontSize: 32)),
        // RotateAnimatedText('DIFFERENT'),
        ]
        ),
      ),
    );
  }
}
