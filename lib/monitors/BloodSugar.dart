import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';


class BloodsugarMonitor extends StatefulWidget {

  BloodsugarMonitor({ required this.width, required this.height});

  double width;
  double height;

  @override
  _BloodsugarMonitorMonitorState createState() => _BloodsugarMonitorMonitorState();
}

class _BloodsugarMonitorMonitorState extends State<BloodsugarMonitor> {



  bool bell4 = false;

  bool alarm4 = false;

  bool cval = false;

  double bmi=0;



  final _formKey=GlobalKey<FormState>();
  int bloodsugar=0;

  void trySubmit(BuildContext context) async
  {
    final isvalid = _formKey.currentState!.validate();

    // context.read(bleprovider).device.writeCharacteristic("4fafc201-1fb5-459e-8fcc-c5c9c331914b", "47b0d1da-1f86-11eb-adc1-0242ac120002", Uint8List.fromList([10]), false);

    if (isvalid) {
      _formKey.currentState!.save();
      print(bloodsugar);
      context.read(bleprovider).Sugar=bloodsugar;
      Navigator.pop(context);
      setState(() {

      });

    }
    else
    {
      return null;
    }
  }


  Widget SugarEntry(BuildContext context)
  {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(width: 3,color: Colors.white),
          borderRadius:BorderRadius.only(topRight:Radius.circular(50) ,topLeft:Radius.circular(50) ),
        ),
        child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text("Blood Sugar",
                          style:TextStyle(
                              fontSize: 20,
                              color: Colors.orange
                          ) ,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: TextFormField(
                              key: ValueKey("BMI"),
                              keyboardType:TextInputType.number,
                              validator: (value){
                                // int systolicValidator=int.parse(value);
                                if(value!.isEmpty)
                                {
                                  return "Please Enter Value";
                                }
                                else if(int.parse(value)>200)
                                {
                                  return "Please Enter Valid Value";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: context.read(bleprovider).Sugar.toString(),
                                border:OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 5)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              ),
                              onSaved: (val){
                                bloodsugar=int.parse(val!);
                              },
                            ),
                          ),
                        ),
                        MaterialButton(onPressed: (){
                          trySubmit(context);

                        },
                          child:Icon(FontAwesomeIcons.solidEnvelope,color: Colors.orange,size: 30,),
                        ),
                      ],

                    ),
                  ),
                ]
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height:  MediaQuery.of(context).orientation==Orientation.portrait? widget.height*0.2:widget.height*0.4,//150
        width:MediaQuery.of(context).orientation==Orientation.portrait? widget.width*0.28:widget.width*0.158,//100
        child: Container(
            decoration: BoxDecoration(
                border:Border.all()
            ),
            //         final _respiration=watch(respirationprovider).respirationrate;
            //       final rrMax=context.read(vitalprovider).rsMax;
            //     final rrMin=context.read(vitalprovider).rsMin;
            // if((rrMin>_respiration || rrMax<_respiration) && alarm4)
            // {
            //   bell4=true;
            // }
            // else
            // {
            //   bell4=false;
            // }
            child:Center(
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Consumer(
                            builder: (context,watch,child){
                              cval=watch(blinkprovider2).blink;
                              return SvgPicture.asset("assets/glucose-meter.svg",color:cval?Color(0xFFD50000):Colors.white,width:17,height:17,);
                            },
                          ),
                          // SvgPicture.asset("assets/glucose-meter.svg",color:cval?Color(0xFFD50000):Colors.white,width: 17,height: 17,),
                          Text(
                            'B.Glucose',
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),
                          ),

                        ],
                      ),
                      // Consumer(//dummy for rr
                      //
                      //   builder: (context,watch,child){
                      //     final rr=watch(bleprovider).rr_rate2;
                      //
                      //     return Text(rr.toString(),style:TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.deepOrangeAccent),);
                      //   },
                      // ),
                      Text("${context.read(bleprovider).Sugar}",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.deepOrangeAccent),),
                      Text("${context.read(bleprovider).time}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),

                Consumer(
                  builder: (context,watch,child){
                  final bmi=watch(bmiproviders2).bmi;

                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("BMI",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
                        Text(bmi.toString().substring(0,4) ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
                      ],
                    ),
                  );
                },
                )
                      // Consumer(
                      //   builder: (context,watch,child){
                      //     final foo=watch(bleprovider);
                      //     final weight=context.read(patientProvider).weight;
                      //     final height=context.read(patientProvider).height;
                      //     if(height==null || weight==null)
                      //       {
                      //          bmi=0;
                      //       }
                      //     else{
                      //        bmi=weight/(height*height);
                      //     }
                      //
                      //     return Container(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //         children: [
                      //           Text("BMI",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
                      //           Text(bmi.toString().substring(0,4) ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.white),),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // )
                    ],
                  )
            )
        )
    );
  }
}
