//
//
// import 'package:chart_sparkline/chart_sparkline.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:patient_monitor/main.dart';
//
// Widget ECG(BuildContext context,double width,double height,int order,bool gain)
// {
//   return SizedBox(
//     width: MediaQuery.of(context).orientation==Orientation.portrait? width*0.72:width*0.842,//260
//     height:  MediaQuery.of(context).orientation==Orientation.portrait?height*0.36:height*.5,//200//0.25
//     child: GestureDetector(
//       onDoubleTap: (){
//         if(order==2)
//         {
//           order=3;
//
//         }
//         else
//         {
//           order=2;
//         }
//       },
//       onTap: (){
//         gain=!gain;
//         print(gain);
//       },
//       child: Container(
//           decoration: BoxDecoration(
//             border:Border.all(),
//             color: Colors.black,
//           ),
//           child:Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 20,),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   "ECG",
//                   style:
//                   TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
//                 ),
//               ),
//               Consumer(
//                 builder: (context, watch, child){
//                   final _ecg=watch(ecgpro);
//                   // ymax=_ecg.dataToFilter.reduce(max);
//                   // ymin=_ecg.dataToFilter.reduce(min);
//                   return _ecg==null?
//                   Text("Loading",style: TextStyle(color: Colors.pink,fontSize: 20),):
//                   Container(
//                     height: gain?200:150,
//                     child:Sparkline(
//                       enableGridLines: true,
//                       lineColor: Colors.white,
//                       sharpCorners: false,
//                       pointsMode: PointsMode.last,
//                       lineWidth: 1,
//                       min:context.read(bleprovider).ymin,
//                       max:context.read(bleprovider).ymax,
//                       pointColor: Colors.white70,
//                       pointSize: 8,
//                       data:_ecg.ecg
//                       // data:context.read(bleprovider).dataToFilter,
//                     ),
//                   );
//                 },
//               ),
//             ],
//           )
//       ),
//     ),
//   );
// }