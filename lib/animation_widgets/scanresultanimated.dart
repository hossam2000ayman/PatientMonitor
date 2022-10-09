import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:math' as math;
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:patient_monitor_nullsafety/screens/patientdetails2(working%20on%20it).dart';


import '../main.dart';

class Scanresult extends StatefulWidget {
  String name;
  Scanresult(this.name);
  _ScanresultState createState() => _ScanresultState();
}

// Use TickerProviderStateMixin if you have multiple AnimationControllers
class _ScanresultState extends State<Scanresult>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    animation = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(animController)
      ..addListener(() {
        // Empty setState because the updated value is already in the animation field
        setState(() {});
      });

    animController.forward();
  }

  bool connect_button_disabled=false;


  @override
  Widget build(BuildContext context) {
    return
        Consumer(
            builder: (context, watch, child) {

              final connectionstate=watch(connectonstate);

              return connectionstate==DeviceConnectionState.connected? CurrenPatient():Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(30),
                child:  Column(
                  children: [
                    Container(
// width: animation.value,
                      height: animation.value,
                      child: ListTile(title: Text(widget.name,style: TextStyle(color: Colors.green[900],fontSize: 20,fontWeight: FontWeight.bold),),
                          trailing:
                          MaterialButton(child: Text("Connect",style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              if(true)
                              {
                                bool ok=true;
                                connect_button_disabled=true;
                                await context.read(bleprovider).connect(context.read(bleprovider).deviceid);
                                context.read(bleprovider).check_connectionstatus();
                                // setState(() {
                                //   connectionstates=context.read(bleprovider).connectionstate.toString();
                                // });

                              }

                            },
                            color: Colors.green[900],

                          )
                      ),
                    ),
                  ],
                ),
              );
            }
        );

  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }
}


