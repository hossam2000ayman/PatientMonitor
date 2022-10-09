



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_monitor_nullsafety/VitalsLimitProvider.dart';
import 'package:patient_monitor_nullsafety/screens/Finddevice3.dart';
import 'package:patient_monitor_nullsafety/screens/connecting.dart';
import 'package:patient_monitor_nullsafety/screens/patientinfo.dart';
import 'package:wakelock/wakelock.dart';

import '../AlarmSettings.dart';
import '../main.dart';
import 'devicescreen3.dart';

class CurrenPatient extends StatelessWidget {
   CurrenPatient({ Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future popout(context,String id,String name,double age,String fileno) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        DeviceScreen4(d: id,
            name: name,
            age: age,
            fileNo: fileno))); //DeviceScreen2(age: age,name: name,fileNo: fileno,device: devices,d: id,)
    // Navigator.pop(context);
  }

  showAlertDialog(BuildContext context,String id) {

    Widget cancelButton = TextButton(
      child: Text("Cancel",style: TextStyle(color: Colors.green[900]),),
      onPressed:  () {
        FlutterBeep.playSysSound(50);
        Navigator.of(context).pop(false);
      },
    );
    Widget launchButton = TextButton(
      child: Text("Discharge",style: TextStyle(color: Colors.green[900]),),
      onPressed:  () {
        context.read(patientProvider).Discharge(id);
        Navigator.of(context).pop(false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20) )),
      title: Text("Notice",style: TextStyle(color: Colors.green[900]),),
      content: Text("Would you like to approve Discharge of this Patient",style: TextStyle(color: Colors.green[900]),),
      actions: [
        cancelButton,
        launchButton,
      ],
    );

    // show the dialog
    showDialog(
      context:context,
      builder: ( dailogecontext) {
        return alert;
      },
    );
  }


  @override
    Widget build(BuildContext context) {
      return Container(
    //     key: _scaffoldKey,
    //     appBar: AppBar(title: Row(
    //             children: [
    //             SizedBox(width: MediaQuery.of(context).size.width*0.2,),
    //         Column(
    //         children: [
    //             Text("IQRAA"),
    //             Text("Patient Monitoring System",style: TextStyle(fontSize: 12),)
    //                 ],
    //               ),
    //             ],
    //           ),
    //             backgroundColor: Colors.green[900],
    //             automaticallyImplyLeading: false,
    // ),
    child: Consumer(
      builder: (context,watch,child){
        final patient=watch(patientAdmitted);

        final connectionstate=watch(connectonstate2).deviceconnectionstate;
        if(connectionstate==DeviceConnectionState.disconnected) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context)  {
              // return DeviceScreen(device: r.device,);
              // return PatientDetail();
              return Connect();
            }));
          });
        }

          return patient.when(
            data: (data){

              if(data.docs.isEmpty)
                {
                  return Center(
                    child: GestureDetector(
                      onTap: () async {
                        // await  widget.device.connect();
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (context) {
                        //   // return PatientInfo(device: context.read(device),);
                        // }));
                      },
                      child: CircleAvatar(
                        radius: 150,
                        child: Text("Please Tap to Add new Patient"),
                      ),
                    ),
                  );
                }
              context.read(patientProvider).add_height(data.docs.first.get("Height"));
              context.read(patientProvider).add_weight(data.docs.first.get("Weight"));
              // print( context.read(patientProvider).height);
              // print(context.read(patientProvider).weight);
              return

                   Column(
                        children: [
                          DataTable(
                            showBottomBorder: true,
                              columnSpacing: 20,
                              columns: [
                                  DataColumn(label: Text("NAME")),
                                DataColumn(label: Text("AGE")),
                                DataColumn(label: Text("Weight")),
                                DataColumn(label: Text("File No")),
                                DataColumn(label: Text("Room No"))
                              ],
                              rows:[ DataRow(cells: [
                                DataCell(Text(data.docs.first.get("Name").toString().substring(0,5))),
                                DataCell(Text(data.docs.first.get("Age").toString())),
                                DataCell(Row(
                                  children: [
                                    data.docs.first.get("Weight")==null?
                                    Icon(FontAwesomeIcons.questionCircle)
                                        :Text(data.docs.first.get("Weight").toString()),
                                      Text("KG"),
                                  ]
                                )
                                ),

                                DataCell(
                                    data.docs.first.get("FileNo").isEmpty?Icon(FontAwesomeIcons.questionCircle) :Text(data.docs.first.get("FileNo").toString())),
                                DataCell(data.docs.first.get("RoomNo").isEmpty?Icon(FontAwesomeIcons.questionCircle):Text(data.docs.first.get("RoomNo").toString())),
                              ])
                            ]
                          ),
                          SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MaterialButton(

                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20) )),
                                child: Text("    Discharge    ",style: TextStyle(color: Colors.white,fontSize: 17),),
                                onPressed: (){
                                  return showAlertDialog(context,data.docs.first.id.toString());

                                },
                                color: Colors.green[900],
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20) )),
                                child: Text("Start Monitoring",style: TextStyle(color: Colors.white,fontSize: 17),),
                                onPressed: () async{
                                  // context.read(bleprovider).start_sending_to_cloud();
                                  context.read(vitalprovider).patient_id=data.docs.first.id.toString();
                                 await context.read(vitalprovider).vitalfromcloud();
                                  await  Wakelock.enable();
                                  context.read(bleprovider).getservices2();
                                 await context.read(bleprovider).start_sending_to_cloud();
                                  context.read(bleprovider).timer_start=true;
                                  // // await context.read(bleprovider).getServicesandCharcterstics().onError((error, stackTrace) {
                                  //
                                  //   print("Error");
                                  //
                                  // });
                                  context.read(bleprovider).add_patient_id(data.docs.first.id.toString());


                                  // context.read(bleprovider).timer_start=true;
                                  context.read(alarmprovider).canceltimer=false;
                                  context.read(alarmprovider).canceltimer_battery=false;
                                  context.read(alarmprovider).soundAlarm();
                                  context.read(alarmprovider).soundAlarm_battery();
                                  context.read(alarmprovider).startAlarmTimer();
                                  context.read(bleprovider).calculate_bmi(context.read(patientProvider).height, context.read(patientProvider).weight);
                                  popout(context, data.docs.first.id.toString(),
                                      data.docs.first.get("Name").toString(), data.docs.first.get('Age'),
                                      data.docs.first.get('FileNo').toString());

                                  // context.read(bmiprovider).calculatebmi( context.read(patientProvider).weight, context.read(patientProvider).height);
                                  // await context.read(bleprovider).read_characterstics();
                                },
                                color: Colors.green[900],
                              ),
                            ],
                          ),

                        ],
                      );
                // Text(data.docs.first.get("Name"));

            },
            loading:()=>CircularProgressIndicator() ,
            error: (_,__)=>Container(
              child: Text("OOPS"),
            ),
        );
      },
    ),
    );
  }
}
