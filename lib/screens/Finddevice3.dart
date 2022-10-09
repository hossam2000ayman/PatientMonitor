import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_monitor_nullsafety/animation_widgets/scanresultanimated.dart';
import 'package:patient_monitor_nullsafety/animation_widgets/waitingscreen.dart';
import 'package:patient_monitor_nullsafety/main.dart';





class FindDeviceScreen3 extends StatelessWidget{


  CollectionReference d=FirebaseFirestore.instance.collection("Patients");





  bool found=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Consumer(
                    builder: (context, watch, child) {

                      // final scans = watch(scanprovider).scanResult;

                      final scans = watch(deviceid2).val;

                      if(scans.isNotEmpty)
                        {
                          found=true;
                        }
                      else
                        {
                          found=false;
                        }
                      return
                        found?
                        Scanresult("IQRAA"):
                          Center(child: Waiting()) ;
                    },
                  )
                ]
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async
        {
           context.read(bleprovider).scan();
          // context.read(scanprovider).addscan();

         // ScanResult val= context.read(bleprovider).value;
         //  if(val!=null)
         //    {
         //      context.read(scaned).addscan(val);
         //    }
        },
        child: Text("Scan"),
        backgroundColor:Colors.green[900],
      ),
    );
  }
}

