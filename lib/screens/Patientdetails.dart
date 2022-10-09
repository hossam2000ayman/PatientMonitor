import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient_monitor_nullsafety/screens/patientinfo.dart';

import '../main.dart';
import 'devicescreen3.dart';

//old design not using

class PatientDetail extends StatelessWidget {

  CollectionReference d=FirebaseFirestore.instance.collection("Patients");

  Future popout(context,String id,String name,double age,String fileno) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) =>
        DeviceScreen4(d: id,name: name,age: age,fileNo: fileno)));//DeviceScreen2(age: age,name: name,fileNo: fileno,device: devices,d: id,)
   Navigator.pop(context);
    // await updateTimes();
    // print(vitals);
}
  @override
  Widget build(BuildContext context) {
   final _device= context.read(bleprovider).deviceid;
        return Scaffold(
          appBar: AppBar(title: Row(
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
          ),
      body: StreamBuilder(
    stream: d.where('Device',isEqualTo:_device).where("Status",isEqualTo: "Admitted" ).snapshots(),
    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text("Loading");
      }
      if (snapshot.hasError) {
        return Text("Error:${snapshot.error}");
      }
      if (snapshot.data!.docs.isEmpty) {
        return Center(
          child: GestureDetector(
            onTap: () async {
              // await  widget.device.connect();
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) {
              //   // return PatientInfo(device: _device,);
              // }));
            },
            child: CircleAvatar(
              radius: 150,
              child: Text("Please Tap to Add new Patient"),
            ),
          ),
        );
      }

      else {
        return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot docs) {
                Map<String, dynamic> data = docs.data() as Map<String, dynamic>;
              print(docs.id);
              return Dismissible(

                key: Key("item"),
                child: GestureDetector(
                  onTap: () async
                  {
                    // await context.read(bleprovider).getServicesandCharcterstics();
                    // await context.read(bleprovider).read_characterstics();
                    popout(context, docs.id.toString(),
                        data['Name'].toString(), data['Age'],
                        data['FileNo'].toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Name: ", style: TextStyle(
                                  color: Color(0xFF3E2723),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),),
                              Text(data['Name'].toString(), style: TextStyle(
                                  color: Color(0xFF3E2723),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Age    :", style: TextStyle(
                                  color: Color(0xFF3E2723),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),),
                              Text(data['Age'].toInt().toString(),
                                  style: TextStyle(color: Color(0xFF3E2723),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                background: Container(
                  color: Color(0xFFFFCDD2),
                ),
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm"),
                        content: const Text(
                            "Would you like to approve Discharge of this Patient"),
                        actions: <Widget>[
                          MaterialButton(
                              color: Colors.white,
                              onPressed: () {
                                d.doc(docs.id.toString()).update({
                                  "Status": "Discharged",
                                  "Date of Discharge": DateTime.now()
                                });
                                Navigator.of(context).pop(true);
                              },
                              child: const Text("DISCHARGE")
                          ),
                          MaterialButton(
                            color: Colors.white,
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("CANCEL"),
                          ),
                        ],
                        backgroundColor: Color(0xFF80D8FF),
                        elevation: 24,
                      );
                    },
                  );
                },
              );
            }).toList()
        );
      }
    })
    );
  }
}
