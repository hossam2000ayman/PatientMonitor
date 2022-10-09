import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_monitor_nullsafety/screens/RRLimit.dart';

import '../AlarmSettings.dart';
import '../VitalsLimitProvider.dart';
import '../main.dart';


class RespirationMonitor extends StatefulWidget {

  RespirationMonitor({ required this.width, required this.height});

  double width;
  double height;

  @override
  _RespirationMonitorState createState() => _RespirationMonitorState();
}

class _RespirationMonitorState extends State<RespirationMonitor> {



  bool bell4 = false;

  bool alarm4 = true;

  bool cval = false;

  void restartAlarm()
  {
    Timer.periodic(Duration(seconds: 60), (timer) {

      if(alarm4==false)
      {
        alarm4=true;
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
        alarm4=false;
        setState(() {

        });
        restartAlarm();
      },
      onTap: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => RRlimit()));

      },
      child: SizedBox(
        height:  MediaQuery.of(context).orientation==Orientation.portrait? widget.height*0.2:widget.height*0.4,//150
        width:MediaQuery.of(context).orientation==Orientation.portrait? widget.width*0.28:widget.width*0.158,//100
        child: Container(
          decoration: BoxDecoration(
              border:Border.all()
          ),
    //         final _respiration=watch(respirationprovider).respirationrate;
    //       final rrMax=context.read(vitalprovider).rsMax;
    //     final rrMin=context.read(vitalprovider).rsMin;
    // if((rrMin>_respiration || rrMax<_respiration) && alarm4)
    // {
    //   bell4=true;
    // }
    // else
    // {
    //   bell4=false;
    // }
          child:Center(
                child: Consumer(
                  builder: (context,watch,child){
                    final _respiration=watch(respirationprovider2).respiration;
                    final rrMax=watch(vitalprovider).rsMax;
                    final rrMin=watch(vitalprovider).rsMin;
                    cval=watch(blinkprovider2).blink;
                    final leadoff=context.read(bleprovider).temperature;
                    if((rrMin>_respiration || rrMax<_respiration)  && _respiration!=0 &&alarm4)
                    {

                      bell4=true;
                      context.read(alarmprovider).Respalarm=true;
                      context.read(alarmprovider).playAlarm();
                    }
                    else
                    {

                      bell4=false;
                      context.read(alarmprovider).Respalarm=false;
                      context.read(alarmprovider).playAlarm();
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Icon(FontAwesomeIcons.lungs,size:15,color:cval?Color(0xFFD50000): Colors.white,
                            ),
                            Text(
                              'RR',
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),
                            ),
                          ],
                        ),
                        // leadoff==0?
                        // Text("0",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.cyanAccent),)
                            Text("${_respiration}",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.cyanAccent),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(rrMin.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
                            Icon( FontAwesomeIcons.bell,size:alarm4? 15:12,color:bell4?Colors.black:(alarm4? Colors.blue:Colors.white),),
                            Text(rrMax.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8,color: Colors.white),)
                          ],
                        ),
                        Icon(FontAwesomeIcons.solidBell,size: 25,color: bell4?(Color(0xFFD50000)):Colors.black)
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
