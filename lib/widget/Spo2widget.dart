//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:patient_monitor/VitalsLimitProvider.dart';
// import 'package:patient_monitor/main.dart';
// import 'package:patient_monitor/screens/SpoLimit.dart';
//
// Widget SPO2(double width,double height,BuildContext context,bool alarm2,bool bell2,bool cval)
// {
//   return GestureDetector(
//     onDoubleTap: (){
//       alarm2=!alarm2;
//     },
//     onTap: ()
//     {
//
//       if(alarm2)
//       {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => SPO2limit()));
//       }
//     },
//     child: SizedBox(
//         height:  MediaQuery.of(context).orientation==Orientation.portrait? height*0.2:height*0.4,//150
//         width:MediaQuery.of(context).orientation==Orientation.portrait? width*0.28:width*0.158,//100
//         child: Container(
//             decoration: BoxDecoration(
//                 border:Border.all(),
//                 color: Colors.black
//             ),
//             child:Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Consumer(
//                         builder:(context, watch, child){
//                           final _spo2=watch(saturation2).spo2;
//                           cval=!cval;
//                           return Icon(FontAwesomeIcons.tint,size:15,color: cval?Color(0xFFD50000):Colors.white,);
//                         },
//                       ),
//                       Text(
//                         'SPO2%',
//                         style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),
//                       ),
//                     ],
//                   ),
//                   Consumer(
//                     builder: (context, watch, child) {
//                       final _spo2=watch(saturation2).spo2;
//                       return Text("${_spo2.toString()}",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.lightGreenAccent),);
//                     },
//                   ),
//                   Consumer(
//                     builder: (context,watch,child){
//                       final _spo2=watch(saturation2).spo2;
//                       final spo2L=context.read(vitalprovider).spo2Min;
//                       if(_spo2<spo2L && alarm2)
//                       {
//                         bell2=true;
//                       }
//                       else
//                       {
//                         bell2=false;
//                       }
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(alarm2?spo2L.toString():"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
//                           Icon(alarm2? FontAwesomeIcons.bell:FontAwesomeIcons.bellSlash,size:alarm2? 15:12,color:bell2?Colors.black:(alarm2? Colors.blue:Colors.white),),],
//                       );
//                     },
//                   ),
//                   Consumer(
//                       builder: (context,watch,child)
//                       {
//                         final _spo2=watch(saturation2).spo2;
//                         return Icon(FontAwesomeIcons.solidBell,size: 25,color: bell2?(cval? Color(0xFFD50000):Colors.white):Colors.black);
//                       }
//                   )
//                 ],
//               ),
//             )
//         )
//     ),
//   );
// }