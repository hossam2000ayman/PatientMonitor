

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient_monitor_nullsafety/animation_widgets/bluetoothlogo.dart';
import 'package:patient_monitor_nullsafety/animation_widgets/location.dart';
import 'package:patient_monitor_nullsafety/screens/Finddevice3.dart';



import '../main.dart';




class Connect extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
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
             backgroundColor: Colors.green[900],
            automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: ()
        {
          FirebaseAuth.instance.signOut();

        },
          icon:Icon(Icons.person),tooltip: "LogOut",),
        IconButton(onPressed: (){

          FlutterBluetoothSerial.instance.requestEnable();
          // context.read(bleprovider).disconnect(context.read(bleprovider).deviceid);
          // FlutterBlueElves.instance.androidOpenBluetoothService((isOk) => print(isOk));




        },
        icon: Icon(Icons.bluetooth),)
        ],
      ),
      body: Consumer(
        builder: (context, watch, child){
          final status = watch(bluetoothstatus);
          return status.map(
              data: (_)=>_.value==BleStatus.ready?FindDeviceScreen3():
              Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Turn On",style: TextStyle(fontSize: 40,color: Color(0xFF3E2723)),),
                      // Icon(FontAwesomeIcons.bluetooth,size: 150,color:Color(0xFF80D8FF),),
                      // Text("Bluetooth & Loction ",style: TextStyle(fontSize: 40,color: Color(0xFF3E2723)),),
                      // Text("Please Enable the loction",style: TextStyle(fontSize: 20,color: Color(0xFF3E2723)),),
                      AnimationPage(),
                      Location()
                    ],
                  ),
                ),
              ),

              loading: (_)=>CircularProgressIndicator(),

              error: (_)=>Text("Error please close the app and reload it")
          );
        },
      ),
    );
  }
}

