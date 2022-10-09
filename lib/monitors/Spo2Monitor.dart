import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_monitor_nullsafety/screens/SpoLimit.dart';
import '../AlarmSettings.dart';
import '../VitalsLimitProvider.dart';
import '../main.dart';


class Spo2 extends StatefulWidget {

  Spo2({ required this.height, required this.width});
  double width;
  double height;

  @override
  _Spo2State createState() => _Spo2State();
}

class _Spo2State extends State<Spo2> {


  bool bell2 = false;

  bool alarm2 = true;

  bool cval=false;


  void restartAlarm()
  {
    Timer.periodic(Duration(seconds: 60), (timer) {

      if(alarm2==false)
      {
        alarm2=true;
        setState(() {

        });
      }
      print("periodic");
      timer.cancel();

    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: (){
        alarm2=false;
        setState(() {

        });
        restartAlarm();
      },
      onTap: ()
      {

        // if(alarm2)
        // {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => SPO2limit()));
        // }
        Navigator.push(context, MaterialPageRoute(builder: (context) => SPO2limit()));
      },
      child: SizedBox(
        height:  MediaQuery.of(context).orientation==Orientation.portrait? widget.height*0.2:widget.height*0.4,//150
        width:MediaQuery.of(context).orientation==Orientation.portrait? widget.width*0.28:widget.width*0.158,//100
        child: Container(
          decoration: BoxDecoration(
              border:Border.all(),
              color: Colors.black
          ),
          child:Center(
                child: Consumer(
                  builder: (context,watch,child){
                    final _spo2=watch(saturation2);
                    final spo2L=watch(vitalprovider).spo2Min;
                    final alarmturnoff=context.read(alarmprovider).alarmTurnOff;
                    cval=watch(blinkprovider2).blink;
                    if(_spo2.spo2<spo2L && alarm2 && _spo2.spo2!=0)
                    {

                    bell2=true;
                    context.read(alarmprovider).Spo2alarm=true;
                    context.read(alarmprovider).playAlarm();
                    }
                    else
                    {
                      print("alarmturnoff spo2");
                      print(alarmturnoff);
                    bell2=false;
                    context.read(alarmprovider).Spo2alarm=false;
                    context.read(alarmprovider).playAlarm();
                    }
                    return  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(FontAwesomeIcons.tint,size:15,color: cval?Color(0xFFD50000):Colors.white,),
                            Text(
                              'SPO2%',
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),
                            ),
                          ],
                        ),
                        Text("${_spo2.spo2.toString()}",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.lightGreenAccent),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(spo2L.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
                            Icon(FontAwesomeIcons.bell,size:15,color:bell2?Colors.black:(alarm2? Colors.blue:Colors.white),),],
                        ),
                        Icon(FontAwesomeIcons.solidBell,size: 25,color: bell2?( Color(0xFFD50000)):Colors.black)
                      ],
                    );
                  },
                ),
              )
          )
        ),
      );
  }
}
