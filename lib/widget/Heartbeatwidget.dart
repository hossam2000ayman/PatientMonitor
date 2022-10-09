//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:patient_monitor/main.dart';
// import 'package:patient_monitor/screens/HBlimit.dart';
//
// import '../VitalsLimitProvider.dart';
//
// Widget HBM(double width,double height,BuildContext context,bool alarm1,bool bell,bool cval)
// {
//   return GestureDetector(
//     onDoubleTap: (){
//       alarm1=!alarm1;
//     },
//     onTap: (){
//
//       if(alarm1)
//       {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => HBlimit()));
//       }
//
//     },
//     child: SizedBox(
//         height:  MediaQuery.of(context).orientation==Orientation.portrait? height*0.2:height*0.4,//150
//         width:MediaQuery.of(context).orientation==Orientation.portrait? width*0.28:width*0.158,//100
//         child: Container(
//             decoration: BoxDecoration(
//               color: Colors.black,
//               border:Border.all(),
//             ),
//             child:Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Consumer(
//                         builder:(context, watch, child){
//                           final _heartbeat=watch(heartbeats);
//                           cval=!cval;
//                           return Icon(FontAwesomeIcons.heartbeat,
//                             size:15,
//                             color: cval?Color(0xFFD50000):Colors.white,);
//                         },
//                       ),
//                       Text(
//                         'BPM',
//                         style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),
//                       ),
//                     ],
//                   ),
//                   Consumer(
//                     builder: (context, watch, child) {
//                       final _heartbeat=watch(heartbeats);
//                       return Text(
//                         "${_heartbeat.toString()}",
//                         style:TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.yellow),);
//                     },
//
//                   ),
//                   Consumer(
//                     builder: (context,watch,child)
//                     {
//                       final _heartbeat=watch(heartbeats);
//                       final hbmin=context.read(vitalprovider).hbMin;
//                       final hbmax=context.read(vitalprovider).hbMax;
//                     //   if((hbmin>_heartbeat.data.value || hbmax<_heartbeat.data.value) && alarm1)
//                     //   {
//                     //     bell=true;
//                     //   }
//                     //   else
//                     //   {
//                     //     bell=false;
//                     //   }
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(alarm1?hbmin.toString():"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
//                           Icon(alarm1?FontAwesomeIcons.bell:FontAwesomeIcons.bellSlash,size:alarm1? 15:12,color:bell?Colors.black:(alarm1? Colors.blue:Colors.white),),
//                           Text(alarm1?hbmax.toString():"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
//                         ],
//                       );
//                     },
//                   ),
//                   Consumer(
//                       builder: (context,watch,child)
//                       {
//                         final _heartbeat=watch(heartbeats);
//                         return Icon(FontAwesomeIcons.solidBell,size: 25,color: bell?(cval? Color(0xFFD50000):Colors.white):Colors.black);
//                       }
//                   )
//                 ],
//               ),
//             )
//         )
//     ),
//   );
// }