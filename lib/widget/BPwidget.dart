//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:patient_monitor/main.dart';
// import 'package:patient_monitor/screens/vitals2.dart';
//
// import '../VitalsLimitProvider.dart';
//
// Widget Bp(double width,double height,BuildContext context,bool alarm5,bool bell5,bool cval,String d1)
// {
//   return GestureDetector(
//     onLongPress:  (){
//
//     },
//     onDoubleTap: (){
//       alarm5=!alarm5;
//     },
//     onTap: (){
//       if(alarm5)
//       {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => Vitals2()));
//       }
//     },
//     child: SizedBox(
//       height:MediaQuery.of(context).orientation==Orientation.portrait? height*0.3:height*0.4,//150
//       width:MediaQuery.of(context).orientation==Orientation.portrait? width*0.36:width*0.421,//130
//       child: Container(
//           decoration: BoxDecoration(
//               border:Border.all()
//           ),
//           child: Container(
//               decoration: BoxDecoration(
//                   border:Border.all()
//               ),
//               child:Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Consumer(
//                               builder:(context,watch,child){
//                                 final _systolic=watch(systoliicprovider).systolic;
//                                 cval=!cval;
//                                 return  SvgPicture.asset("assets/BPICON.svg",color:cval?Color(0xFFD50000):Colors.white,width: 17,height: 17,);
//                               },
//                             ),
//                             Text(
//                               'NIBP',
//                               style:
//                               TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color:Colors.white),
//                             ),
//                           ],
//                         ),
//                         Consumer(
//                           builder: (context,watch,child){
//                             final _systolic=watch(systoliicprovider).systolic;
//                             final _diastolic=watch(systoliicprovider).diastolic;
//                             return Text(_systolic.toString()+"/"+_diastolic.toString(),style:
//                             TextStyle(fontWeight: FontWeight.bold, fontSize:30,color:Colors.blue,));
//                           },
//                         ),
//                         Consumer(
//                           builder: (context,watch,child){
//                             final _systolic=context.read(systoliicprovider).systolic;
//                             // final sysMax=context.read(vitalprovider).sysMax;
//                             // final sysMin=context.read(vitalprovider).sysMin;
//                             // final dysMax=context.read(vitalprovider).dysMax;
//                             // final dysMin=context.read(vitalprovider).dysMin;
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(alarm5?"${context.read(vitalprovider).sysMin.toInt()}-${context.read(vitalprovider).sysMax.toInt()}":"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
//                                 Icon((alarm5?FontAwesomeIcons.bell:FontAwesomeIcons.bellSlash),size:alarm5? 15:12,color:bell5?Colors.black:(alarm5? Colors.blue:Colors.white)),
//                                 Text(alarm5?"${context.read(vitalprovider).dysMin.toInt()}-${context.read(vitalprovider).dysMax.toInt()}":"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
//                               ],
//                             );
//                           },
//                         ),
//                         Consumer(
//                           builder: (context,watch,child){
//                             final _systolic=watch(systoliicprovider).systolic;
//                             final _diastolic=watch(systoliicprovider).diastolic;
//                             final sysMax=context.read(vitalprovider).sysMax;
//                             final sysMin=context.read(vitalprovider).sysMin;
//                             final dysMax=context.read(vitalprovider).dysMax;
//                             final dysMin=context.read(vitalprovider).dysMin;
//                             if((_systolic>sysMax||_systolic<sysMin|| _diastolic>dysMax||_diastolic<dysMin )&& alarm5)
//                             {
//                               bell5=true;
//                             }
//                             else
//                             {
//                               bell5=false;
//                             }
//                             return Icon(bell5?FontAwesomeIcons.solidBell:Icons.arrow_drop_up,size:bell5? 25:5,color:bell5?(cval? Color(0xFFD50000):Colors.white): Color(0xFFD50000),);
//                           },
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Consumer(
//                           builder: (context,watch,child){
//                             final _systolic=watch(systoliicprovider).systolic;
//                             final _diastolic=watch(systoliicprovider).diastolic;
//                             return  Text("MAP"+" "+((_systolic+2*_diastolic)/3).toInt().toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Color(0xFFD50000)),);
//                           },
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Column(
//                               children: [
//                                 Text("LR Time",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
//                                 // Text(DateFormat.jm().format(DateTime.now()),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
//                                 Text(d1,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
//                               ],
//                             ),
//                           ],
//                         ),
//
//
//                       ],
//
//                     ),
//                   ],
//                 ),
//               )
//           )
//       ),
//     ),
//   );
// }