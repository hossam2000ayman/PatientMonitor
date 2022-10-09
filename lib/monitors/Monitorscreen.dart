



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'BloodSugar.dart';
import 'BpMonitor.dart';
import 'EcgMonitor.dart';
import 'HeartBeatMonitor.dart';
import 'NameAgeMonitor.dart';
import 'RespirationMonitor.dart';
import 'Spo2Monitor.dart';
import 'TemperatureMonitor.dart';

class Monitor extends StatelessWidget {
  // Peripheral device;
  String d;
  String name;
  String fileNo;
  double age;
  // BleManager bleManager;

  Monitor({ required this.d, required this.name, required this.age, required this.fileNo});

  String d1=DateFormat.jm().format(DateTime.now());
  bool bell = false;
  bool alarm1 = false;
  bool bell2 = false;
  bool alarm2 = false;
  bool bell3 = false;
  bool alarm3 = false;
  bool bell4 = false;
  bool alarm4 = false;
  bool bell5=false;
  bool alarm5=false;
  bool cval=false;
  int order=0;
  bool gain=true;

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    var padding=MediaQuery.of(context).padding;
    double height=MediaQuery.of(context).size.height;
    double Nheight=height-padding.top-padding.bottom;
    return Container(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Column(
              children: [
                NameAgeMonitor(age: age,d: d,fileNo: fileNo,height: height,name: name,Nheight: Nheight,padding: padding,width: width,),
                EcgMonitor(height: height,width: width,),
                // ECG(context, width, height, order, gain),
                // CircularProgressIndicator(backgroundColor: Colors.black,color: Colors.black,),
                // CircularProgressIndicator(),
                SizedBox(
                   //space for tempgraph
                  width: MediaQuery.of(context).orientation==Orientation.portrait? width*0.72:width*0.842,//260,
                   height:  MediaQuery.of(context).orientation==Orientation.portrait? height*0.19:height*0.6,//150,
                 ),
                Row(
                  children: [
                    BpMonitor(height:height,width: width),

                   // Bp(width, height, context, alarm5, bell5, cval,d1),
                    SizedBox(
                      height: MediaQuery.of(context).orientation==Orientation.portrait? height*0.13:height*0.4,//150
                      width: MediaQuery.of(context).orientation==Orientation.portrait? width*0.36:width*0.421,//130
                      child: Container(
                        decoration: BoxDecoration(
                            border:Border.all(),
                            color: Colors.black,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BloodsugarMonitor(width: width,height: height,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  HeartBeat(width: width,height: height,),
                  // HBM(width, height, context, alarm1, bell, cval),
                  Spo2(height: height,width: width,),
                  // SPO2(width, height, context, alarm2, bell2, cval),
                  TemperatureMonitor(height: height,width: width,),
                  // TEMPERATURE(width, height, context, alarm3, bell3, cval),
                  SizedBox(
                    width:MediaQuery.of(context).orientation==Orientation.portrait? width*0.28:width*0.158,//100
                    height: MediaQuery.of(context).orientation==Orientation.portrait? height*0.08:height*0.2,//150,
                  ),
                  RespirationMonitor(width: width,height: height,)
                  // RESPIRATION(width, height, context, alarm4, bell4, cval)
                ]
            )
          ]
       ),
    );
  }
}
