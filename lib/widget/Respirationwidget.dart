//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:patient_monitor/VitalsLimitProvider.dart';
// import 'package:patient_monitor/main.dart';
// import 'package:patient_monitor/screens/RRLimit.dart';
//
// Widget RESPIRATION(double width,double height,BuildContext context,bool alarm4,bool bell4,bool cval)
// {
//   return GestureDetector(
//     onDoubleTap: (){
//       alarm4=!alarm4;
//     },
//     onTap: (){
//       if(alarm4)
//       {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => RRlimit()));
//       }
//     },
//     child: SizedBox(
//         height:  MediaQuery.of(context).orientation==Orientation.portrait? height*0.2:height*0.4,//150
//         width:MediaQuery.of(context).orientation==Orientation.portrait? width*0.28:width*0.158,//100
//         child: Container(
//             decoration: BoxDecoration(
//                 border:Border.all()
//             ),
//             child:Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Consumer(
//                         builder: (context,watch,child){
//                           final _respiration=watch(respirationprovider).respirationrate;
//                           cval=!cval;
//                           return Icon(FontAwesomeIcons.lungs,size: 15,color:cval?Color(0xFFD50000): Colors.white,
//                           );
//                         },
//                       ),
//                       Text(
//                         'RR',
//                         style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),
//                       ),
//                     ],
//                   ),
//                   Consumer(
//                     builder: (context,watch,child){
//                       final _respiration=watch(respirationprovider).respirationrate;
//                       return Text("${_respiration}",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.cyanAccent),);
//                     },
//                   ),
//                   Consumer(
//                     builder: (context,watch,child){
//                       final _respiration=watch(respirationprovider).respirationrate;
//                       final rrMax=context.read(vitalprovider).rsMax;
//                       final rrMin=context.read(vitalprovider).rsMin;
//                       if((rrMin>_respiration || rrMax<_respiration) && alarm4)
//                       {
//                         bell4=true;
//                       }
//                       else
//                       {
//                         bell4=false;
//                       }
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(alarm4?rrMax.toString():"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8,color: Colors.white),),
//                           Icon(alarm4? FontAwesomeIcons.bell:FontAwesomeIcons.bellSlash,size:alarm4? 15:12,color:bell4?Colors.black:(alarm4? Colors.blue:Colors.white),),
//                           Text(alarm4?rrMin.toString():"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8,color: Colors.white),)
//                         ],
//                       );
//                     },
//                   ),
//                   Consumer(
//                     builder: (context,watch,child){
//                       final _respiration=watch(respirationprovider).respirationrate;
//                       return Icon(FontAwesomeIcons.solidBell,size: 25,color: bell4?(cval? Color(0xFFD50000):Colors.white):Colors.black);
//                     },
//                   )
//                 ],
//               ),
//             )
//         )
//     ),
//   );
// }