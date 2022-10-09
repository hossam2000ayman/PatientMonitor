import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../VitalsLimitProvider.dart';

class Vitals2 extends StatefulWidget {
  // Vitals2({this.dysMax,this.dysMin,this.sys_correction,this.dys_correction,this.sysMax,this.sysMin});
  @override
  _Vitals2State createState() => _Vitals2State();
}

class _Vitals2State extends State<Vitals2> {


  @override
  Widget build(BuildContext context) {
    final sys_correction=context.read(vitalprovider).sys_correction;
    final dys_correction=context.read(vitalprovider).dys_correction;
    final sysMax=context.read(vitalprovider).sysMax;
    final dysMax=context.read(vitalprovider).dysMax;
    final sysMin=context.read(vitalprovider).sysMin;
    final dysMin=context.read(vitalprovider).dysMin;
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SvgPicture.asset("assets/BPICON.svg",color:Color(0xFFD50000),width: 50,height: 50,),
                  Text("BP Alarm Settings",style: TextStyle(fontSize: 20,color: Colors.deepPurple,fontWeight: FontWeight.bold),),
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
                            Text("Systolic Correction:",style: TextStyle(fontSize: 17,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                            Text(sys_correction.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFD50000))),
                            Slider(
                              onChanged: (val)
                              {
                                context.read(vitalprovider).add_syscorretcion(val.toInt());
                                // sys_correction=val.truncateToDouble();
                                setState(() {

                                });
                              },
                              min: -50,
                              max: 50,
                              value: sys_correction.truncateToDouble(),
                              label: sys_correction.truncateToDouble().toString(),
                              activeColor: Colors.deepOrange,
                              divisions:96,
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
                            Text("Diastolic Correction:",style: TextStyle(fontSize: 17,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                            Text(dys_correction.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Color(0xFFD50000))),
                            Slider(
                              onChanged: (val)
                              {
                                context.read(vitalprovider).add_diacorretcion(val.toInt());
                                // dys_correction=val.truncateToDouble();
                                setState(() {

                                });
                              },
                              min: -50,
                              max: 50,
                              value: dys_correction.truncateToDouble(),
                              label: dys_correction.truncateToDouble().toString(),
                              activeColor: Colors.deepOrange,
                              divisions:96,
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
                            Text("Systolic Lower Limit:",style: TextStyle(fontSize: 17,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                            Text(sysMin.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFD50000))),
                            Slider(
                              onChanged: (val)
                              {
                                context.read(vitalprovider).add_sysMin(val.truncateToDouble());

                                // sysMin=val.roundToDouble();
                                setState(() {

                                });
                              },
                              min: 0,
                              max: 300,
                              value: sysMin.toDouble(),
                              label: sysMin.toString(),
                              activeColor: Colors.deepPurple,
                              divisions: 300,
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
                            Text("Systolic Upper Limit:",style: TextStyle(fontSize: 17,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                            Text(sysMax.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFD50000))),
                            Slider(
                              onChanged: (val)
                              {
                                context.read(vitalprovider).add_sysMax(val.truncateToDouble());

                                // sysMax=val.roundToDouble();
                                setState(() {

                                });

                              },
                              min: 0,
                              max: 300,
                              value: sysMax.toDouble(),
                              label: sysMax.toString(),
                              activeColor: Colors.deepPurple,
                              divisions: 300,
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
                            Text("Dystolic Lower Limit:",style: TextStyle(fontSize: 17,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                            Text(dysMin.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFD50000))),
                            Slider(
                              onChanged: (val)
                              {
                                context.read(vitalprovider).add_dysMin(val.truncateToDouble());

                                // dysMin=val.roundToDouble();
                                setState(() {

                                });
                              },
                              min: 0,
                              max: 150,
                              value: dysMin.toDouble(),
                              label: dysMin.toString(),
                              activeColor: Colors.deepPurple,
                              divisions: 150,
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
                            Text("Dystolic Upper Limit:",style: TextStyle(fontSize: 17,color: Colors.deepPurple,fontWeight: FontWeight.bold)),
                            Text(dysMax.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFD50000))),
                            Slider(
                              onChanged: (val)
                              {
                                context.read(vitalprovider).add_dysMax(val.truncateToDouble());

                                // dysMax=val.roundToDouble();
                                setState(() {

                                });
                              },
                              min: 0,
                              max: 150,
                              value: dysMax.toDouble(),
                              label: dysMax.toString(),
                              activeColor: Colors.deepPurple,
                              divisions: 150,
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
                      Navigator.pop(context,);
                      await context.read(vitalprovider).updateVitaltoCloud();
                    },
                  )],
              ),
            ],
          ),
        ),
      ),
    );
  }
}