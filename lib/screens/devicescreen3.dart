import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_monitor_nullsafety/AlarmSettings.dart';
import 'package:patient_monitor_nullsafety/monitors/Monitorscreen.dart';
import 'package:patient_monitor_nullsafety/widget/Bloodglucosewidget.dart';
import 'package:patient_monitor_nullsafety/widget/weightwidget.dart';
import 'package:patient_monitor_nullsafety/widget/heightwidget.dart';
import 'package:wakelock/wakelock.dart';


import '../main.dart';
import 'connecting.dart';


class DeviceScreen4 extends StatefulWidget {

  DeviceScreen4({ required this.name, required this.d, required this.age, required this.fileNo});
  String d;
  String name;
  String fileNo;
  double age;

  @override
  State<DeviceScreen4> createState() => _DeviceScreen4State();
}

class _DeviceScreen4State extends State<DeviceScreen4> {
  @override
  Widget build(BuildContext context) {
    // context.read(bleprovider).read_characterstics();
    double width=MediaQuery.of(context).size.width;
    var padding=MediaQuery.of(context).padding;
    double height=MediaQuery.of(context).size.height;
    double Nheight=height-padding.top-padding.bottom;
    return
      Consumer(
          builder: (context, watch, child)
          {
            final connectionstate=watch(connectonstate);

            if (connectionstate==DeviceConnectionState.disconnected)
              {
                Future.delayed(Duration(seconds: 1),()async{
                 await context.read(bleprovider).dispose();
                  Navigator.pop(context);
                });

                return Text("");
              }
            return WillPopScope(
              onWillPop: () async=>false,
              child: Scaffold(
                appBar:
                AppBar(title: Row(
                  children: [
                    SizedBox(width: 18,),
                    Column(
                      children: [
                        Text("IQRAA"),
                        Text("Patient Monitoring System",style: TextStyle(fontSize: 12),)
                      ],
                    ),
                  ],
                ),
                  backgroundColor: Colors.green[900],
                  actions: [
                    Consumer(
                      builder: (context,watch,child){
                        final batterylevel=watch(batterylevelindicator2).voltage;

                        // final charging=context.read(bleprovider).charging;

                        if(batterylevel>=4.0)
                        {
                          context.read(alarmprovider).batterlow=false;
                          return Row(
                            children: [
                              Transform.rotate(
                                  angle: -pi/2,
                                  child: Icon(FontAwesomeIcons.batteryFull,color: Colors.white,)),
                              Text(batterylevel.toStringAsFixed(4).substring(0,4),style: TextStyle(color: Colors.white,fontSize: 10),),

                            ],
                          );
                        }
                        else if(batterylevel>=3.85 && batterylevel<4.0)
                        {
                          context.read(alarmprovider).batterlow=false;
                          return Row(
                            children: [
                              Transform.rotate(
                                  angle: -pi/2,
                                  child: Icon(FontAwesomeIcons.batteryThreeQuarters,color: Colors.white,)),
                              Text(batterylevel.toStringAsFixed(4).substring(0,4),style: TextStyle(color: Colors.white,fontSize: 10),)
                            ],
                          );
                        }
                        else if(batterylevel>=3.6 && batterylevel<3.85)
                        {
                          context.read(alarmprovider).batterlow=false;
                          return Row(
                            children: [
                              Transform.rotate(
                                  angle: -pi/2,
                                  child: Icon(FontAwesomeIcons.batteryHalf,color: Colors.white,)),
                              Text(batterylevel.toStringAsFixed(4).substring(0,4),style: TextStyle(color: Colors.white,fontSize: 10),)
                            ],

                          );
                        }
                        else if(batterylevel>=3.35 && batterylevel<3.6)
                        {

                          return Row(
                            children: [
                              Transform.rotate(
                                  angle: -pi/2,
                                  child: Icon(FontAwesomeIcons.batteryQuarter,color: Color(0xFFD50000),)),
                              Text(batterylevel.toStringAsFixed(4).substring(0,4),style: TextStyle(color: Colors.white,fontSize: 10),)
                            ],
                          );
                        }
                        else
                        {
                          context.read(alarmprovider).batterlow=true;
                          return Row(
                            children: [
                              Transform.rotate(angle: -pi/2,child: Icon(FontAwesomeIcons.batteryEmpty,color: Colors.red)),
                              Text(batterylevel.toStringAsFixed(4).substring(0,4),style: TextStyle(color: Colors.white,fontSize: 10),)
                            ],
                          );
                        }
                        //  if(batterylevel>4)
                        //    {
                        //      return Icon(
                        //          FontAwesomeIcons.chargingStation,color: Colors.white
                        //      );
                        //    }
                        // else if(batterylevel<3.1)
                        //    {
                        //      return Transform.rotate(angle: -pi/2,child: Icon(FontAwesomeIcons.batteryEmpty,color: Colors.red));
                        //    }
                        //  else
                        //    {
                        //      if(batterylevel>3.8)
                        //        {
                        //          return Transform.rotate(
                        //              angle: -pi/2,
                        //              child: Icon(FontAwesomeIcons.batteryFull,color: Colors.white,));
                        //        }
                        //      else if(batterylevel<=3.6 && batterylevel>=3.4)
                        //        {
                        //          return Transform.rotate(
                        //              angle: -pi/2,
                        //              child: Icon(FontAwesomeIcons.batteryThreeQuarters,color: Colors.white,));
                        //      }
                        //      else if(batterylevel<=3.4  && batterylevel>=3.2)
                        //        {
                        //          return Transform.rotate(
                        //              angle: -pi/2,
                        //              child: Icon(FontAwesomeIcons.batteryHalf,color: Colors.white,));
                        //        }
                        //      else
                        //        {
                        //          return Transform.rotate(
                        //              angle: -pi/2,
                        //              child: Icon(FontAwesomeIcons.batteryQuarter,color: Color(0xFFD50000),));
                        //        }
                        //        }
                      },
                    ),
                    IconButton(onPressed: ()async{

                      await Wakelock.disable();
                      // await context.read(bleprovider).disconnect( context.read(bleprovider).deviceid);

                      // context.read(bleprovider).clearScanandDevice();
                      context.read(bleprovider).clear_patient_id();
                      // context.read(bleprovider).timer_start=false;
                      // context.read(bleprovider).cancel_transaction();
                      context.read(bleprovider).deviceconnection=true;
                      // context.read(bleprovider).clear_respiration();
                      context.read(alarmprovider).canceltimer=true;
                      context.read(alarmprovider).canceltimer_battery=true;


                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context){
                      //   return Connect();
                      // })
                      // );
                      // Navigator.of(context).pop();
                      await context.read(bleprovider).dispose();
                      FlutterBluetoothSerial.instance.requestDisable();
                      // setState(() {
                      //
                      // });


                    },
                        icon: Icon(Icons.bluetooth_connected)),

                    // IconButton(onPressed: (){
                    //
                    // }
                    //   ,icon: Icon(Icons.refresh),)
                    IconButton(onPressed: ()async{
                     await context.read(bleprovider).getservices2();
                    },
                        icon: Icon(Icons.refresh))
                  ],
                ),

                body:SingleChildScrollView(
                  child: SingleChildScrollView(
                    child: Container(
                        color: Colors.black,
                        child:
                        // Monitorwithanimation()
                        Monitor(age: widget.age,d: widget.d,name:widget.name,fileNo: widget.fileNo,)

                    ),
                  ),
                ),
                backgroundColor: Colors.black,
                drawer: Drawer(
                    elevation: 10,
                    child:Scaffold(
                      appBar: AppBar(
                        backgroundColor: Colors.green[900],
                        title: Text("Patient Information"),
                      ),
                      body: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              weightwidget(widget.d),
                              heightwidget(widget.d),
                              glucoswidget()
                            ],
                          ),
                        ),
                      ),
                    )
                ),
              ),
            );
          }
    //     child: WillPopScope(
    //     onWillPop: () async=>false,
    //     child: Scaffold(
    //       appBar:
    //       AppBar(title: Row(
    //         children: [
    //           SizedBox(width: 18,),
    //           Column(
    //             children: [
    //               Text("IQRAA"),
    //               Text("Patient Monitoring System",style: TextStyle(fontSize: 12),)
    //             ],
    //           ),
    //         ],
    //       ),
    //         backgroundColor: Colors.green[900],
    //         actions: [
    //           Consumer(
    //             builder: (context,watch,child){
    //               final batterylevel=watch(batterylevelindicator2).voltage;
    //
    //               // final charging=context.read(bleprovider).charging;
    //
    //               if(batterylevel>=4.0)
    //                 {
    //                   context.read(alarmprovider).batterlow=false;
    //                   return Row(
    //                     children: [
    //                       Transform.rotate(
    //                           angle: -pi/2,
    //                           child: Icon(FontAwesomeIcons.batteryFull,color: Colors.white,)),
    //                       Text(batterylevel.toStringAsFixed(4).substring(0,4),style: TextStyle(color: Colors.white,fontSize: 10),),
    //
    //                     ],
    //                   );
    //                 }
    //               else if(batterylevel>=3.85 && batterylevel<4.0)
    //                 {
    //                   context.read(alarmprovider).batterlow=false;
    //                   return Row(
    //                     children: [
    //                       Transform.rotate(
    //                           angle: -pi/2,
    //                           child: Icon(FontAwesomeIcons.batteryThreeQuarters,color: Colors.white,)),
    //                       Text(batterylevel.toStringAsFixed(4).substring(0,4),style: TextStyle(color: Colors.white,fontSize: 10),)
    //                     ],
    //                   );
    //                 }
    //               else if(batterylevel>=3.6 && batterylevel<3.85)
    //                 {
    //                   context.read(alarmprovider).batterlow=false;
    //                   return Row(
    //                     children: [
    //                       Transform.rotate(
    //                           angle: -pi/2,
    //                           child: Icon(FontAwesomeIcons.batteryHalf,color: Colors.white,)),
    //                       Text(batterylevel.toStringAsFixed(4).substring(0,4),style: TextStyle(color: Colors.white,fontSize: 10),)
    //                     ],
    //
    //                   );
    //                 }
    //               else if(batterylevel>=3.35 && batterylevel<3.6)
    //                 {
    //
    //                   return Row(
    //                     children: [
    //                       Transform.rotate(
    //                           angle: -pi/2,
    //                           child: Icon(FontAwesomeIcons.batteryQuarter,color: Color(0xFFD50000),)),
    //                       Text(batterylevel.toStringAsFixed(4).substring(0,4),style: TextStyle(color: Colors.white,fontSize: 10),)
    //                     ],
    //                   );
    //                 }
    //               else
    //                 {
    //                   context.read(alarmprovider).batterlow=true;
    //                   return Row(
    //                     children: [
    //                       Transform.rotate(angle: -pi/2,child: Icon(FontAwesomeIcons.batteryEmpty,color: Colors.red)),
    //                       Text(batterylevel.toStringAsFixed(4).substring(0,4),style: TextStyle(color: Colors.white,fontSize: 10),)
    //                     ],
    //                   );
    //                 }
    //              //  if(batterylevel>4)
    //              //    {
    //              //      return Icon(
    //              //          FontAwesomeIcons.chargingStation,color: Colors.white
    //              //      );
    //              //    }
    //              // else if(batterylevel<3.1)
    //              //    {
    //              //      return Transform.rotate(angle: -pi/2,child: Icon(FontAwesomeIcons.batteryEmpty,color: Colors.red));
    //              //    }
    //              //  else
    //              //    {
    //              //      if(batterylevel>3.8)
    //              //        {
    //              //          return Transform.rotate(
    //              //              angle: -pi/2,
    //              //              child: Icon(FontAwesomeIcons.batteryFull,color: Colors.white,));
    //              //        }
    //              //      else if(batterylevel<=3.6 && batterylevel>=3.4)
    //              //        {
    //              //          return Transform.rotate(
    //              //              angle: -pi/2,
    //              //              child: Icon(FontAwesomeIcons.batteryThreeQuarters,color: Colors.white,));
    //              //      }
    //              //      else if(batterylevel<=3.4  && batterylevel>=3.2)
    //              //        {
    //              //          return Transform.rotate(
    //              //              angle: -pi/2,
    //              //              child: Icon(FontAwesomeIcons.batteryHalf,color: Colors.white,));
    //              //        }
    //              //      else
    //              //        {
    //              //          return Transform.rotate(
    //              //              angle: -pi/2,
    //              //              child: Icon(FontAwesomeIcons.batteryQuarter,color: Color(0xFFD50000),));
    //              //        }
    //              //        }
    //             },
    //           ),
    //           IconButton(onPressed: ()async{
    //
    //             await Wakelock.disable();
    //             // await context.read(bleprovider).disconnect( context.read(bleprovider).deviceid);
    //
    //             // context.read(bleprovider).clearScanandDevice();
    //             context.read(bleprovider).clear_patient_id();
    //             // context.read(bleprovider).timer_start=false;
    //             // context.read(bleprovider).cancel_transaction();
    //             context.read(bleprovider).deviceconnection=true;
    //             // context.read(bleprovider).clear_respiration();
    //             context.read(alarmprovider).canceltimer=true;
    //             context.read(alarmprovider).canceltimer_battery=true;
    //
    //
    //             // Navigator.of(context).push(
    //             //     MaterialPageRoute(builder: (context){
    //             //   return Connect();
    //             // })
    //             // );
    //             Navigator.of(context).pop();
    //             FlutterBluetoothSerial.instance.requestDisable();
    //
    //           },
    //               icon: Icon(Icons.bluetooth_connected)),
    //
    //           // IconButton(onPressed: (){
    //           //
    //           // }
    //           //   ,icon: Icon(Icons.refresh),)
    //         ],
    //       ),
    //
    //       body:SingleChildScrollView(
    //         child: SingleChildScrollView(
    //           child: Container(
    //               color: Colors.black,
    //               child:
    //               // Monitorwithanimation()
    //               Monitor(age: age,d: d,name:name,fileNo: fileNo,)
    //
    //         ),
    //       ),
    //     ),
    //       backgroundColor: Colors.black,
    //       drawer: Drawer(
    //           elevation: 10,
    //           child:Scaffold(
    //             appBar: AppBar(
    //               backgroundColor: Colors.green[900],
    //               title: Text("Patient Information"),
    //             ),
    //             body: SingleChildScrollView(
    //               child: Container(
    //                 child: Column(
    //                   children: [
    //                     weightwidget(d),
    //                     heightwidget(d),
    //                     glucoswidget()
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           )
    //       ),
    //     ),
    // ),
      );
  }
}