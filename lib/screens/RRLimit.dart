import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../VitalsLimitProvider.dart';

class RRlimit extends StatefulWidget {


  @override
  _RRlimitState createState() => _RRlimitState();
}

class _RRlimitState extends State<RRlimit> {
  @override
  Widget build(BuildContext context) {
    final RRUL=context.read(vitalprovider).rsMax;
    final RRLL=context.read(vitalprovider).rsMin;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        excludeHeaderSemantics: true,
        backgroundColor: Colors.green[900],
        title: Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width*0.2,),
            Column(
              children: [
                Text("IQRAA"),
                Text("Patient Monitoring System",style: TextStyle(fontSize: 12),)
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(FontAwesomeIcons.lungs,size: 50,color:Color(0xFFD50000),),
                Text("RR Alarm Settings",style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontWeight: FontWeight.bold),),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: 250,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border:Border.all()
                      ),
                      child: Column(
                        children: [
                          Text("Lower Limit:",style: TextStyle(fontSize: 17,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                          Text(RRLL.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFD50000))),
                          Slider(
                            onChanged: (val)
                            {
                             context.read(vitalprovider).add_rsMin(val.toInt());
                              setState(() {

                              });
                            },
                            min: 0,
                            max: 50,
                            value: RRLL.toDouble(),
                            label: RRLL.toString(),
                            activeColor: Colors.deepPurple,
                            divisions:50,
                          ),
                        ],
                      ),
                    )
                ),

                SizedBox(
                    width: 250,
                    child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border:Border.all()
                          ),
                      child: Column(
                        children: [
                          Text("Upper Limit:",style: TextStyle(fontSize: 17,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                          Text(RRUL.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFD50000))),
                          Slider(
                            onChanged: (val)
                            {
                              context.read(vitalprovider).add_rsMax(val.toInt());
                              setState(() {

                              });
                            },
                            min: 0,
                            max: 50,
                            value: RRUL.toDouble(),
                            label: RRUL.toString(),
                            activeColor: Colors.deepPurple,
                            divisions: 50,
                          ),
                        ],
                      ),
                    )
                ),

                MaterialButton(

                  shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  textColor: Colors.white,
                  color:Color(0xFFD50000),
                  child: Text('OK'),
                  onPressed: () async{
                    Navigator.pop(context);
                    await context.read(vitalprovider).updateVitaltoCloud();
                  },
                )],
            ),
          ],
        ),
      ),
    );
  }
}
