import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';


class BMIMonitor extends StatefulWidget {

  BMIMonitor({ required this.width, required this.height});

  double width;
  double height;

  @override
  _BMIMonitorMonitorState createState() => _BMIMonitorMonitorState();
}

class _BMIMonitorMonitorState extends State<BMIMonitor> {



  bool bell4 = false;

  bool alarm4 = false;

  bool cval = false;

  final _formKey=GlobalKey<FormState>();
  late double bmi;

  void trySubmit(BuildContext context) async
  {
    final isvalid = _formKey.currentState!.validate();

    // context.read(bleprovider).device.writeCharacteristic("4fafc201-1fb5-459e-8fcc-c5c9c331914b", "47b0d1da-1f86-11eb-adc1-0242ac120002", Uint8List.fromList([10]), false);

    if (isvalid) {
      _formKey.currentState!.save();
      print(bmi);
      context.read(bleprovider).BMI=bmi;
      Navigator.pop(context);
      setState(() {

      });

    }
    else
    {
      return null;
    }
  }


  Widget BmiEntry(BuildContext context)
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
                        Text("BMI",
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
                                labelText: context.read(bleprovider).BMI.toString(),
                                border:OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 5)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              ),
                              onSaved: (val){
                                bmi=double.parse(val!);
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
    return GestureDetector(
      onLongPress: (){
        showModalBottomSheet(context: context,builder:(BuildContext context)
        {
          return BmiEntry(context);
        },
            isScrollControlled: true,
            backgroundColor: Colors.black,
            shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)))
        );
      },
      child: SizedBox(
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
                child:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          'BMI',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10,color: Colors.white),
                        ),
                        Text("${context.read(bleprovider).BMI}",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.cyanAccent),),

                      ],
                    )
              )
          )
      ),
    );
  }
}

