import 'package:flutter/material.dart';
import 'dart:math' as math;


class Location extends StatefulWidget {
  _LocationState createState() => _LocationState();
}

// Use TickerProviderStateMixin if you have multiple AnimationControllers
class _LocationState extends State<Location>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    );

    animation = Tween<double>(
      begin: 50,
      end: 100,
    ).animate(animController)
      ..addListener(() {
        // Empty setState because the updated value is already in the animation field
        setState(() {});
      })..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animController.forward();
        }
      });;

    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        // height: animation.value,
        //  width:animation.value ,
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Icon(Icons.location_on,size: animation.value,color:Colors.blue,
        ),
      );
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}