import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_monitor_nullsafety/screens/TempLimit.dart';

import '../AlarmSettings.dart';
import '../VitalsLimitProvider.dart';
import '../main.dart';


class TemperatureMonitor extends StatefulWidget {

  TemperatureMonitor({ required this.width, required this.height});

  double width;
  double height;

  @override
  _TemperatureMonitorState createState() => _TemperatureMonitorState();
}

class _TemperatureMonitorState extends State<TemperatureMonitor> {




  bool bell3 = false;

  bool alarm3 = true;

  bool cval = false;


  void restartAlarm()
  {
    Timer.periodic(Duration(seconds: 60), (timer) {

      if(alarm3==false)
      {
        alarm3=true;
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
        alarm3=false;
        setState(() {
          restartAlarm();
        });
      },
      onTap: ()
      {

          Navigator.push(context, MaterialPageRoute(builder: (context) => Templimit()));

      },
    //     final _temp=watch(temperatureprovider).tp;
    // final tempmin=context.read(vitalprovider).tpMin;
    // final tempmax=context.read(vitalprovider).tpMax;
    // if((tempmin>_temp || tempmax<_temp) && alarm3)
    // {
    //   bell3=true;
    // }
    // else
    // {
    //   bell3=false;
    // }
      child: SizedBox(
          height:  MediaQuery.of(context).orientation==Orientation.portrait? widget.height*0.2:widget.height*0.4,//150
          width:MediaQuery.of(context).orientation==Orientation.portrait? widget.width*0.28:widget.width*0.158,//100
          child: Container(
            decoration: BoxDecoration(
                border:Border.all()
            ),
            child:Center(
                  child: Consumer(
                    builder: (context,watch,child){
                      final _temp=watch(temperatureprovider2).tp;
                      final _temp_correction=watch(vitalprovider).tempCorrection;
                      context.read(bleprovider).temp_correction=_temp_correction;
                      final _temp_with_correction=_temp+_temp_correction;
                      final tempmin=watch(vitalprovider).tpMin;
                      final tempmax=watch(vitalprovider).tpMax;
                      cval=watch(blinkprovider2).blink;
                      if((tempmin>_temp_with_correction || tempmax<_temp_with_correction) && alarm3 && _temp!=0)
                      {

                        bell3=true;
                       context.read(alarmprovider).Tempalarm=true;
                       context.read(alarmprovider).playAlarm();
                      }
                      else
                      {

                        bell3=false;
                        context.read(alarmprovider).Tempalarm=false;
                        context.read(alarmprovider).playAlarm();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(FontAwesomeIcons.thermometerEmpty,
                                    size:17,
                                    color:cval?Color(0xFFD50000): Colors.white,
                                  ),
                                  Text(
                                    "\u00B0"+'C',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),
                                  ),
                                ],
                              ),
                              _temp==0?
                              Text("${(_temp)}",style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.deepPurple[400]),):Text("${_temp_with_correction}",style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.deepPurple[400]),),
                              Consumer(
                                  builder: (context,watch,child) {

                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(tempmin.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
                                        Icon( FontAwesomeIcons.bell,size:12,color:bell3?Colors.black:(alarm3? Colors.blue:Colors.white),),
                                        Text(tempmax.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
                                      ],
                                    );
                                  }
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Icon(Icons.pre),
                                  Icon(bell3 ? FontAwesomeIcons.solidBell : Icons
                                      .arrow_drop_up, size: bell3 ? 25 : 35,
                                    color: bell3 ? (cval
                                        ? Color(0xFFD50000)
                                        : Colors.white) : Color(0xFFD50000),),
                                  Text("${(_temp - 37).toStringAsFixed(1)}",
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.white),)
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                )
            ),
          )
      );
  }
}
