import 'package:flutter/material.dart';

class NameAgeMonitor extends StatelessWidget {

  double width;
  var padding;
  double height;
  double Nheight;
  String d;
  String name;
  String fileNo;
  double age;

  NameAgeMonitor({ required this.height, required this.Nheight,this.padding, required this.width, required this.name, required this.age, required this.d, required this.fileNo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:MediaQuery.of(context).orientation==Orientation.portrait? width*0.72:width*0.842,//260 //landscape 0.842//potrait
      height: MediaQuery.of(context).orientation==Orientation.portrait?height*0.1:height*.2,//80
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border:Border.all()
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name.toString().length<=12?name.toString():name.substring(0,12),style: TextStyle(color: Colors.white,fontSize: 20),),
                  Row(
                    children: [
                      Text("No ",style:TextStyle(color: Colors.white,fontSize: 15)),
                      Text(fileNo.trimRight(),style:TextStyle(color: Colors.white,fontSize: 15)),
                    ],
                  ),
                ],
              ),
              Text(age.toStringAsFixed(0)+"Yrs",style:TextStyle(color: Colors.white,fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
