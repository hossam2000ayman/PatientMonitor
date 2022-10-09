import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../VitalsLimitProvider.dart';

class SPO2limit extends StatefulWidget {
  // int SPO2;


  @override
  _SPO2limit createState() => _SPO2limit();
}

class _SPO2limit extends State<SPO2limit> {

  @override
  Widget build(BuildContext context) {
    final SPO2=context.read(vitalprovider).spo2Min;
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
                Icon(FontAwesomeIcons.tint,size: 50,color:Color(0xFFD50000),),
                Text("SPO2 Alarm Settings",style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontWeight: FontWeight.bold),),
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
                          Text(SPO2.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFD50000))),
                          Slider(
                            onChanged: (val)
                            {
                              context.read(vitalprovider).add_spo2Min(val.toInt());
                              setState(() {

                              });
                            },
                            min: 0,
                            max: 100,
                            value: SPO2.toDouble(),
                            label: SPO2.toString(),
                            activeColor: Colors.deepPurple,
                            divisions:100,
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