import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../VitalsLimitProvider.dart';

class Templimit extends StatefulWidget {


  @override
  _TemplimitState createState() => _TemplimitState();
}

class _TemplimitState extends State<Templimit> {

  List<int> v=[];
  @override
  Widget build(BuildContext context) {
    final Tpul=context.read(vitalprovider).tpMax;
    final Tpll=context.read(vitalprovider).tpMin;
    final tpcorrection=context.read(vitalprovider).tempCorrection;
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
                Icon(FontAwesomeIcons.thermometerEmpty,size: 50,color:Color(0xFFD50000),),
                Text("Temperature Alarm Settings",style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontWeight: FontWeight.bold),),
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
                          Text("Temperature Correction Factor",style: TextStyle(fontSize: 17,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                          Text(tpcorrection.toStringAsFixed(1),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFD50000))),
                          Slider(
                            onChanged: (val)
                            {
                              context.read(vitalprovider).add_tempcorrection(val);
                              setState(() {

                              });
                            },
                            min: 0.0,
                            max: 5.0,
                            value: tpcorrection.toDouble(),
                            label: tpcorrection.toStringAsFixed(1),
                            activeColor: Colors.deepPurple,
                            divisions:25,
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
                          Text("Lower Limit:",style: TextStyle(fontSize: 17,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                          Text(Tpll.toStringAsFixed(1),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFD50000))),
                          Slider(
                            onChanged: (val)
                            {
                             context.read(vitalprovider).add_tpMin(val);
                              setState(() {

                              });
                            },
                            min: 0.0,
                            max: 50.0,
                            value: Tpll.toDouble(),
                            label: Tpll.toStringAsFixed(1),
                            activeColor: Colors.deepPurple,
                            divisions:250,
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
                          Text(Tpul.toStringAsFixed(1),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFD50000))),
                          Slider(
                            onChanged: (val)
                            {
                              context.read(vitalprovider).add_tpMax(val);
                              setState(() {

                              });
                            },
                            min: 0,
                            max: 50,
                            value: Tpul.toDouble(),
                            label: Tpul.toStringAsFixed(1),
                            activeColor: Colors.deepPurple,
                            divisions: 250,
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
                  onPressed: () async {
                    v.add(Tpll.toInt());
                    v.add(Tpul.toInt());
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