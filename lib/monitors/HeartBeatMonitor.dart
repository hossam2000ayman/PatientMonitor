import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_monitor_nullsafety/screens/HBlimit.dart';


import '../AlarmSettings.dart';
import '../VitalsLimitProvider.dart';
import '../main.dart';


class HeartBeat extends StatefulWidget   {

  HeartBeat({ required this.width, required this.height});

  double width;
  double height;

  @override
  _HeartBeatState createState() => _HeartBeatState();
}

class _HeartBeatState extends State<HeartBeat> {




  bool bell = false;

  bool alarm1 = true;

  bool cval = false;




  void restartAlarm()
  {
    Timer.periodic(Duration(seconds: 60), (timer) {

      if(alarm1==false)
        {
          alarm1=true;
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
        alarm1=false;
        setState(() {

        });
        restartAlarm();

      },
      onTap: (){

        // if(alarm1)
        // {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HBlimit()));
        // }

      },
      child: SizedBox(
        height:  MediaQuery.of(context).orientation==Orientation.portrait? widget.height*0.2:widget.height*0.4,//150
        width:MediaQuery.of(context).orientation==Orientation.portrait? widget.width*0.28:widget.width*0.158,//100
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border:Border.all(),
            ),
            child:Center(
                    child: Consumer(
                      builder: (context,watch,child){
                        final _heartbeat=watch(heartbeats2);
                        final hbmin=watch(vitalprovider).hbMin;
                        final hbmax=watch(vitalprovider).hbMax;

                        cval=watch(blinkprovider2).blink;
                        if((hbmin>_heartbeat.hb || hbmax<_heartbeat.hb) && alarm1 && _heartbeat.hb!=0)
                        {
                          bell=true;
                          print("Hello heartbeat");
                          context.read(alarmprovider).Hbalarm=true;
                          context.read(alarmprovider).playAlarm();
                        }
                        else
                        {
                          bell=false;
                          context.read(alarmprovider).Hbalarm=false;
                          context.read(alarmprovider).playAlarm();

                        }
                        return
                          Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                              Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(FontAwesomeIcons.heartbeat,
                                    size:15,
                                    color: cval?Color(0xFFD50000):Colors.white,
                                  ),
                                  Text(
                                    'BPM',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                              "${_heartbeat.hb.toString()}",
                              style:TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.yellow),),

                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text(hbmin.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
                                  Icon(FontAwesomeIcons.bell,size: 15,color:bell?Colors.black:(alarm1? Colors.blue:Colors.white),),
                                  Text(hbmax.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
                                  ],
                                  ),
                              Icon(FontAwesomeIcons.solidBell,size: 25,color: bell?(Color(0xFFD50000)):Colors.black),

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


// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text(alarm1?hbmin.toString():"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
// Icon(alarm1?FontAwesomeIcons.bell:FontAwesomeIcons.bellSlash,size:alarm1? 15:12,color:bell?Colors.black:(alarm1? Colors.blue:Colors.white),),
// Text(alarm1?hbmax.toString():"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
// ],
// ),