import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../VitalsLimitProvider.dart';

class HBlimit extends StatefulWidget {
  // int hbul;
  // int hbll;
  // HBlimit({this.hbll,this.hbul});

  @override
  _HBlimitState createState() => _HBlimitState();
}

class _HBlimitState extends State<HBlimit> {


  @override
  Widget build(BuildContext context) {
    final hbul=context.read(vitalprovider).hbMax;
    final hbll=context.read(vitalprovider).hbMin;
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
                Icon(FontAwesomeIcons.heartbeat,size: 50,color:Color(0xFFD50000),),
                Text("HeartRate Alarm Settings",style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontWeight: FontWeight.bold),),
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
                          Text(hbll.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFD50000))),
                          Slider(
                            onChanged: (val)
                            {
                              context.read(vitalprovider).add_hbMin(val.toInt());
                              setState(() {

                              });
                            },
                            min: 0,
                            max: 200,
                            value:hbll.toDouble(),
                            label: hbll.toString(),
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
                          Text(hbul.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFD50000))),
                          Slider(
                            onChanged: (val)
                            {
                              context.read(vitalprovider).add_hbMax(val.toInt());
                              setState(() {

                              });
                            },
                            min: 0,
                            max: 200,
                            value:hbul.toDouble(),
                            label: hbul.toString(),
                            activeColor: Colors.deepPurple,
                            divisions: 200,
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