
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

final _hi=GlobalKey<FormState>();
late int systolic;
late int diastolic;


void trySubmit(BuildContext context) async
{
  final isvalid = _hi.currentState!.validate();

  // context.read(bleprovider).device.writeCharacteristic("4fafc201-1fb5-459e-8fcc-c5c9c331914b", "47b0d1da-1f86-11eb-adc1-0242ac120002", Uint8List.fromList([10]), false);

  if (isvalid) {
    _hi.currentState!.save();
    context.read(bleprovider).writedata2(systolic,diastolic);
    context.read(bleprovider).disconnect( context.read(bleprovider).deviceid);
    print(systolic);
    print(diastolic);
    Navigator.pop(context);

  }
  else
    {
      Navigator.pop(context);
      return null;
    }
}
Widget BpCalberation(BuildContext context)
{
  return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(width: 3,color: Colors.white),
        borderRadius:BorderRadius.only(topRight:Radius.circular(50) ,topLeft:Radius.circular(50) ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _hi,
              child: Column(
                children: [
                  Text("Systolic",
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
                        key: ValueKey("systolic"),
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
                          labelText: context.read(bleprovider).systolicset.toString(),
                          border:OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        ),
                        onSaved: (val){
                          systolic=int.parse(val!);
                        },
                      ),
                    ),
                  ),
                  Text("Diastolic",
                    style:TextStyle(
                        fontSize: 20,
                        color: Colors.orange
                    ) ,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TextFormField(
                        key: ValueKey("diastolic"),
                        keyboardType:TextInputType.number,
                        validator: (value){
                          // int diastolicValidtor=int.parse(value);
                          if(value!.isEmpty)
                          {
                            return "Please Enter Value";
                          }
                          else if(int.parse(value)>130)
                          {
                            return "Please Enter Valid Value";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: context.read(bleprovider).diastolicset.toString(),
                          border:OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        ),
                        onSaved: (val){
                          diastolic=int.parse(val!);
                        },
                      ),
                    ),
                  ),
                MaterialButton(onPressed: (){
                  trySubmit(context);

                },
                  child:Text("SET",style: TextStyle(color: Colors.black,fontSize: 15)),
                  color: Colors.orange,
                  // Icon(FontAwesomeIcons.solidEnvelope,color: Colors.orange,size: 30,),
                ),
          ],
        ),
  ),
        ]
  )
  )
  );
}
