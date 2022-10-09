
import 'dart:math';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

class EcgMonitor extends StatefulWidget {

  EcgMonitor({ required this.width, required this.height});
  double width;
  double height;

  @override
  _EcgMonitorState createState() => _EcgMonitorState();
}

class _EcgMonitorState extends State<EcgMonitor> {
  int order=0;

  bool gain=true;

  double ymax=40;

  double ymin=-10;

  double temp_leadoff=0;

  bool freeze=true;

  String arrythmia="";

  List<double> freeze_ecg=[];

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      width: MediaQuery.of(context).orientation==Orientation.portrait? widget.width*0.72:widget.width*0.842,//260
      height:  MediaQuery.of(context).orientation==Orientation.portrait?widget.height*0.36:widget.height*.5,//200//0.25
      child: GestureDetector(
        onDoubleTap: (){
          freeze=!freeze;
          print(freeze);
          setState(() {
          });
        },
        onTap: (){
          gain=!gain;
          print(gain);
        },

        child: Container(
          decoration: BoxDecoration(
            border:Border.all(),
            color: Colors.black,
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "ECG",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
                    ),

                    Consumer(builder: (context,watch,child){
                      final globalheartbeat=watch(bleprovider).globalheartrate;

                      if(globalheartbeat>60 && globalheartbeat<100)
                        {
                          arrythmia="Norma Sinus Rhythm ";
                        }
                      else if(globalheartbeat>100)
                        {
                          arrythmia="Sinus Tachycardia";
                        }
                      else if(globalheartbeat<60)
                        {
                          arrythmia="Sinus Bradycardia";
                        }
                      return Text(arrythmia, style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),);
                    })
                  ],
                ),
              ),
             freeze? Consumer(
                builder: (context, watch, child){
                  // final _ecg=watch(ecgpro);
                  // final _ecg=watch(ecgprovider2);
                  final _ecg=watch(bleprovider);
                  temp_leadoff=context.read(bleprovider).temperature;
                  ymax=context.read(bleprovider).ymax;
                  ymin=context.read(bleprovider).ymin;
                  return
                  // temp_leadoff==0?
                  //     Text("Lead Off ",style: TextStyle(fontSize: 20,color:Colors.white),)
                  // :
                      Container(
                      height: gain?200:150,
                      child:Sparkline(
                      enableGridLines: true,
                      lineColor: Colors.white,
                      sharpCorners: false,
                      pointsMode: PointsMode.last,
                      min:ymin,
                      max:ymax,
                      pointColor: Colors.white70,
                      pointSize: 8,
                      data:_ecg.dataToFilter,
                    )
                    );
                },
              ):
             Container(
                 height: gain?200:150,
                 child:Sparkline(
                   enableGridLines: true,
                   lineColor: Colors.teal,
                   sharpCorners: false,
                   pointsMode: PointsMode.last,
                   min:ymin,
                   max:ymax,
                   pointColor: Colors.white70,
                   pointSize: 8,
                   data:context.read(bleprovider).dataToFilter,
                 )
             ),
            ],
          )
        ),
      ),
    );
  }
}
