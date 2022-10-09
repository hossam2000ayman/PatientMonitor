//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:patient_monitor/VitalsLimitProvider.dart';
// import 'package:patient_monitor/main.dart';
// import 'package:patient_monitor/screens/TempLimit.dart';
//
// Widget TEMPERATURE(double width,double height,BuildContext context,bool alarm3,bool bell3,bool cval)
// {
//   return GestureDetector(
//       onDoubleTap: (){
//         alarm3=!alarm3;
//       },
//       onTap: ()
//       {
//         if(alarm3)
//         {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => Templimit()));
//         }
//       },
//       child: SizedBox(
//         height:  MediaQuery.of(context).orientation==Orientation.portrait? height*0.2:height*0.4,//150
//         width:MediaQuery.of(context).orientation==Orientation.portrait? width*0.28:width*0.158,//100
//         child: Container(
//             decoration: BoxDecoration(
//                 border:Border.all()
//             ),
//             child:Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Consumer(
//                             builder: (context,watch,child){
//                               final _temp=watch(temperatureprovider).tp;
//                               cval=!cval;
//                               return Icon(FontAwesomeIcons.thermometerEmpty,
//                                 size: 17,
//                                 color:cval?Color(0xFFD50000): Colors.white,
//                               );
//                             },
//                           ),
//                           Text(
//                             "\u00B0"+'C',
//                             style:
//                             TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       Consumer(
//                           builder: (context,watch,child)
//                           {
//                             final _temp=watch(temperatureprovider).tp;
//                             return _temp==0?
//                             Text("${(_temp).roundToDouble()}",style:
//                             TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.deepPurple[400]),):Text("${(_temp).roundToDouble()}",style:
//                             TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.deepPurple[400]),);
//                           }
//                       ),
//                       Consumer(
//                           builder: (context,watch,child) {
//                             final _temp=watch(temperatureprovider).tp;
//                             final tempmin=context.read(vitalprovider).tpMin;
//                             final tempmax=context.read(vitalprovider).tpMax;
//                             if((tempmin>_temp || tempmax<_temp) && alarm3)
//                             {
//                               bell3=true;
//                             }
//                             else
//                             {
//                               bell3=false;
//                             }
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(alarm3?tempmin.toString():"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),),
//                                 Icon(alarm3? FontAwesomeIcons.bell:FontAwesomeIcons.bellSlash,size:alarm3? 15:12,color:bell3?Colors.black:(alarm3? Colors.blue:Colors.white),),
//                                 Text(alarm3?tempmax.toString():"",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),)
//                               ],
//                             );
//                           }
//                       ),
//
//                       Consumer(
//                           builder: (context,watch,child) {
//                             final _temp = watch(temperatureprovider).tp;
//                             return Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Icon(Icons.pre),
//                                 Icon(bell3 ? FontAwesomeIcons.solidBell : Icons
//                                     .arrow_drop_up, size: bell3 ? 25 : 35,
//                                   color: bell3 ? (cval
//                                       ? Color(0xFFD50000)
//                                       : Colors.white) : Color(0xFFD50000),),
//                                 Text("${(_temp - 37).roundToDouble()}",
//                                   style: TextStyle(fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                       color: Colors.white),)
//                               ],
//                             );
//                           }
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//         ),
//       )
//   );
// }