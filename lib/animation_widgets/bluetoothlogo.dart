import 'package:flutter/material.dart';
import 'dart:math' as math;






class ResocoderImage extends AnimatedWidget {
  ResocoderImage({
     Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return  Container(
      // height: animation.value,
      //  width:animation.value ,
      alignment: Alignment.center,
      padding: EdgeInsets.all(30),
      child: Icon(Icons.bluetooth,size: animation.value,color:Colors.blue,
      ),
    );
  }
}

class AnimationPage extends StatefulWidget {
  _AnimationPageState createState() => _AnimationPageState();
}

// Use TickerProviderStateMixin if you have multiple AnimationControllers
class _AnimationPageState extends State<AnimationPage>
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

    final curvedAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );

    animation = Tween<double>(
      begin: 50,
      end: 100,
    ).animate(curvedAnimation)
      ..addListener(() {
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
    return ResocoderImage(animation: animation,);
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}