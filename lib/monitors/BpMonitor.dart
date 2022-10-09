

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:patient_monitor_nullsafety/screens/vitals2.dart';

import '../AlarmSettings.dart';
import '../VitalsLimitProvider.dart';
import '../bottomsheet.dart';
import '../main.dart';


class BpMonitor extends StatefulWidget {

  BpMonitor({ required this.width, required this.height});
  double width;
  double height;

  @override
  _BpMonitorState createState() => _BpMonitorState();
}

class _BpMonitorState extends State<BpMonitor> {


  String d=DateFormat.jm().format(DateTime.now());

  bool bell5=true;

  bool alarm5=false;

  bool cval=false;

  void restartAlarm()
  {
    Timer.periodic(Duration(seconds: 60), (timer) {

      if(alarm5==false)
      {
        alarm5=true;
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
      onLongPress:  (){
        print("hello");
        showModalBottomSheet(context: context,builder:(BuildContext context)
            {
              return BpCalberation(context);
            },
          isScrollControlled: true,
          backgroundColor: Colors.black,
            shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)))
        );
        // showMaterialModalBottomSheet(
        //   context: context,
        //   bounce: true,
        //   backgroundColor: Colors.black,
        //   builder: (context) =>BpCalberation(context)
        // );

      },
      onDoubleTap: (){
        alarm5=false;
        setState(() {
        });
        restartAlarm();
      },
      onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => Vitals2()));

      },
      child: SizedBox(
        height:MediaQuery.of(context).orientation==Orientation.portrait? widget.height*0.2:widget.height*0.4,//150
        width:MediaQuery.of(context).orientation==Orientation.portrait? widget.width*0.36:widget.width*0.421,//130
        child: Container(
          decoration: BoxDecoration(
              border:Border.all()
          ),
          child: Container(
            decoration: BoxDecoration(
                border:Border.all()
            ),
            child:Center(
                  child: Consumer(
                    builder: (contex,watch,child){

                      final _systolic=watch(systolicprovider2).systolic;
                      final _diastolic=watch(diastolicprovider2).diastolic;
                      final _sys_correction=watch(vitalprovider).sys_correction;
                      final _dia_correction=watch(vitalprovider).dys_correction;
                      context.read(bleprovider).systolic_Correction=_sys_correction;
                      context.read(bleprovider ).diastolic_Correction=_dia_correction;
                      final _systolic_withCorrection=_systolic+_sys_correction;
                      final _diastolic_withCorrection=_diastolic+_dia_correction;
                      final sysMax=watch(vitalprovider).sysMax;
                      final sysMin=watch(vitalprovider).sysMin;
                      final dysMax=watch(vitalprovider).dysMax;
                      final dysMin=watch(vitalprovider).dysMin;
                      cval=watch(blinkprovider2).blink;
                      if((_systolic_withCorrection>sysMax||_systolic_withCorrection<sysMin|| _diastolic_withCorrection>dysMax||_diastolic_withCorrection<dysMin )&& alarm5 && _systolic!=0 && _diastolic!=0 )
                      {

                        bell5=true;
                        context.read(alarmprovider).Bpalarm=true;
                        context.read(alarmprovider).playAlarm();
                      }
                      else
                      {

                        bell5=false;
                        context.read(alarmprovider).Bpalarm=false;
                        context.read(alarmprovider).playAlarm();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset("assets/BPICON.svg",color:cval?Color(0xFFD50000):Colors.white,width:17,height:17,),
                                  Text(
                                    'NIBP',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color:Colors.white),
                                  ),
                                ],
                              ),
                              _systolic==0||_diastolic==0?
                              Text(_systolic.toString()+"/"+_diastolic.toString(),style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize:30,color:Colors.blue,)):
                              Text(_systolic_withCorrection.toString()+"/"+_diastolic_withCorrection.toString(),style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize:30,color:Colors.blue,)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${context.read(vitalprovider).sysMin.toInt()}-${context.read(vitalprovider).sysMax.toInt()}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
                                  Icon((FontAwesomeIcons.bell),size:12,color:bell5?Colors.black:(alarm5? Colors.blue:Colors.white)),
                                  Text("${context.read(vitalprovider).dysMin.toInt()}-${context.read(vitalprovider).dysMax.toInt()}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
                                ],
                              ),
                              Icon(FontAwesomeIcons.solidBell,size:bell5? 25:5,color:bell5?(Color(0xFFD50000)): Colors.black,),
                              SizedBox(
                                height: 10,
                              ),
                              Text("MAP"+" "+((_systolic+2*_diastolic)/3).toInt().toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Color(0xFFD50000)),),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //   children: [
                              //     Column(
                              //       children: [
                              //         Text("LR Time",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
                              //         // Text(DateFormat.jm().format(DateTime.now()),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
                              //         Text(d,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
                              //       ],
                              //     ),
                              //   ],
                              // ),


                            ],

                          ),
                        ],
                      );
                    },
                  ),
                )
            )
          ),
        ),
      );
  }
}




