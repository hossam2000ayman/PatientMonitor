import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientInfo extends StatefulWidget {
  DiscoveredDevice device;

  PatientInfo({ required this.device});
  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<PatientInfo> {

  final _formKey=GlobalKey<FormState>();
  String _name='';
   late double _age;
   late double _weight;
   late double _height;
  String _fileNo="";
  String _doctor="";
  String _roomNo="";
  String _remarks="";
  String _gender="";
  List<String> searchkeyWord=[];
   late DocumentReference  docref;
   late String docid;

   late int? _value=0;

  void _trySubmit() async
  {

    final isvalid=_formKey.currentState!.validate();

     _gender=_value==0?"Male":"Female";

    if(isvalid)
    {
      _formKey.currentState!.save();
      print(_name);
      print(_age);
      print(_weight);
      print(_height);
      print(_fileNo);
      print(_doctor);
      print(_roomNo);
      print(_remarks);

      // context.read(bmiprovider).calculatebmi(_weight,_height);
      for(int i=0;i<=_name.length;i++)
        {
          if(i+1<=_name.length)
            {
              if(_name.substring(0,i+1)!=null)
                {
                  searchkeyWord.add(_name.substring(0,i+1)!=null?_name.substring(0,i+1).toLowerCase():"");
                  print(_name.substring(0,i+1));
                }

            }


        }
    docref= await FirebaseFirestore.instance.collection("Patients/").add({"Name":_name,
     "Age":_age,
       "Weight":_weight,
       "Height":_height,
       "FileNo":_fileNo,
        "Gender":_gender,
       "Doctor":_doctor,
       "RoomNo":_roomNo,
       "Remarks":_remarks,
      "Date of Admission":DateTime.now(),
      "Status":"Admitted",
      "Device":widget.device.id.toString(),
      "searchkeyword":searchkeyWord,
      // "Gender":_value==0?"Male":"Female"
     });
    docid=docref.id.toString();
    print(docref.id);

    // await FirebaseFirestore.instance.collection("/Devices/${widget.device.id}/Healthparameters/HeartBeat/heartbeat").add({
    //   "Datetime":DateTime.now(),
    //   "PatientsID":docid,
    //   "heartrate":0
    // });
    //   await FirebaseFirestore.instance.collection("/Devices/${widget.device.id}/Healthparameters/SPO2/sp02").add({
    //     "Datetime":DateTime.now(),
    //     "PatientsID":docid,
    //     "SPO2":0
    //   });
    //   await FirebaseFirestore.instance.collection("/Devices/${widget.device.id}/Healthparameters/Temperature/temperature").add({
    //     "Datetime":DateTime.now(),
    //     "PatientsID":docid,
    //     "temperature":0
    //   });
      // widget.submitFn(_userEmail.trim(),_userPassword.trim(),_userUsername.trim(),logIn,context);

      _formKey.currentState!.reset();
      // Navigator.of(context).push(MaterialPageRoute(builder: (context){
      //   return DeviceScreen2(device: widget.device,d: docid,name: _name,age: _age,fileNo: _fileNo,);
      // }));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Patient Details"),
      // actions: [IconButton(icon: Icon(Icons.add),onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context){
      //   return PatientDetail();
      // }));}),],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: ValueKey("patient Name"),
                        validator: (value)
                        {
                          if(value!.isEmpty)
                            {
                              return "Please Enter Name";
                            }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Patient Name",
                          border:OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        ),
                        onSaved: (val){
                          _name=val!;
                        },
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: ValueKey("age"),
                  validator: (value)
                  {
                    if(value!.isEmpty && value.length<2)
                    {
                      return "Please Enter age";
                    }
                    return null;
                  },
                  keyboardType:TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Patient Age",
                    border:OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 5)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                  onSaved: (val){
                    _age=double.parse(val!);
                  },
                ),
              ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            Radio(
                              value: 0,
                              groupValue: _value,
                              activeColor: Color(0xFF6200EE),
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value;
                                  print(_value);
                                });
                              },
                            ),
                          Text("Male"),

                          Radio(
                            value: 1,
                            groupValue: _value,
                            activeColor: Color(0xFF6200EE),
                            onChanged: (int? value) {
                              setState(() {
                                _value = value;
                                print(_value);
                              });
                            },

                          ),
                          Text("Female"),
                            // ListTile(
                            //   title: Text(
                            //     'Radio $i',
                            //
                            //   ),
                            //   leading: Radio(
                            //     value: i,
                            //     groupValue: _value,
                            //     activeColor: Color(0xFF6200EE),
                            //     onChanged: i == 2 ? null:(int? value) {
                            //       setState(() {
                            //         _value = value;
                            //       });
                            //     },
                            //
                            //   ),
                            // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: ValueKey("weight"),
                        // validator: (value)
                        // {
                        //   if(value.isEmpty)
                        //   {
                        //     return "Please Enter weight";
                        //   }
                        //   return null;
                        // },
                        keyboardType:TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Patient weight",
                          border:OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        ),
                        onSaved: (val){
                          if(val!.isEmpty)
                            {
                              _weight=0;
                            }
                          else
                            {
                              _weight=double.parse(val);
                            }

                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: ValueKey("height"),
                        // validator: (value)
                        // {
                        //   if(value.isEmpty)
                        //   {
                        //     return "Please Enter height";
                        //   }
                        //   return null;
                        // },
                        keyboardType:TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Patient height in meters",
                          border:OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        ),
                        onSaved: (val){
                          if(val!.isEmpty)
                          {
                            _height=0;
                          }
                          else
                          {
                            _height=double.parse(val);
                          }

                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: ValueKey("fileNo"),
                        // validator: (value)
                        // {
                        //   if(value.isEmpty)
                        //   {
                        //     return "Please Enter fileNo";
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                          labelText: "Patient File Number",
                          border:OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        ),
                        onSaved: (val){
                          _fileNo=val!;
                        },
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: ValueKey("doctor"),
                        // validator: (value)
                        // {
                        //   if(value.isEmpty)
                        //   {
                        //     return "Please Enter Doctor";
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                          labelText: "Attending Doctor",
                          border:OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        ),
                        onSaved: (val){
                          _doctor =val!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: ValueKey("room"),
                        // validator: (value)
                        // {
                        //   if(value.isEmpty)
                        //   {
                        //     return "Please Enter RoomNo";
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                          labelText: "Patient Room No",
                          border:OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 5)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        ),
                        onSaved: (val){
                          _roomNo=val!;
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLines: 10,
                        key: ValueKey("remarks"),
                        // validator: (value)
                        // {
                        //   if(value.isEmpty)
                        //   {
                        //     return "Please Enter Remarks";
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                          labelText: "Remarks",
                          border:OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 20)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        ),
                        onSaved: (val){
                          _remarks=val!;
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            // RaisedButton(
            //   child: Text("Retrive Data"),
            //   onPressed: () async{
            //     await FirebaseFirestore.instance.collection("Patients").get().then((value) => value.docs.forEach((element) {print(element.data());}));
            //     },
            // ),
          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[900],
        child: Icon(Icons.arrow_forward_ios),
        onPressed: () {
           _trySubmit();
          },
      ),
    );
  }
}
