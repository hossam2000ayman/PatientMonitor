

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../main.dart';


class glucoswidget extends StatefulWidget {




  @override
  _glucoswidgetState createState() => _glucoswidgetState();
}

class _glucoswidgetState extends State<glucoswidget> {


  TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _textFieldController.dispose();
    super.dispose();
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20),bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20) )),
              title: Text('Enter Blood Glucose'),
              content: SingleChildScrollView(
                child: Container(
                  child: TextField(
                    textInputAction: TextInputAction.go,
                    keyboardType:TextInputType.datetime,
                    onSubmitted: (value){
                      if(value.isNotEmpty)
                        {
                          context.read(bleprovider).Sugar=int.parse(_textFieldController.text);
                          context.read(bleprovider).time=DateFormat.jm().format(DateTime.now());
                          _textFieldController.clear();
                          Navigator.of(context).pop(false);
                        }
                      else
                        {
                          Navigator.of(context).pop(false);
                        }
                    },
                    onChanged: (value) {
                      print(value);

                    },
                    controller: _textFieldController,
                    decoration:  InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border:OutlineInputBorder(borderSide: BorderSide(color: Colors.white,width: 5)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  child: Text("Cancel",style: TextStyle(color: Colors.green[900]),),
                  onPressed:  () {
                    _textFieldController.clear();
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text("Ok",style: TextStyle(color: Colors.green[900]),),
                  onPressed:  () {
                    if(_textFieldController.text.isNotEmpty)
                      {
                        context.read(bleprovider).Sugar=int.parse(_textFieldController.text);
                        context.read(bleprovider).time=DateFormat.jm().format(DateTime.now());
                        _textFieldController.clear();
                        Navigator.of(context).pop(false);
                      }
                    else
                      {
                        Navigator.of(context).pop(false);
                      }
                  },
                )

              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
    padding: const EdgeInsets.all(15.0),
        child: Column(
         children: [
          ListTile(
            onTap: (){
              _displayTextInputDialog(context);
            },
            trailing: Text("Tap here to Edit",style: TextStyle(color: Colors.white),),
            tileColor: Colors.blue,
            enabled: true,
            shape: RoundedRectangleBorder(
            side: BorderSide(color:Colors.black, width:1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0),bottom: Radius.circular(25.0))),
            title: Text("Blood Glucose",style: TextStyle(color: Colors.white),),
            subtitle: Consumer(
              builder: (context,watch,child){
                final patientinfo=watch(patientAdmitted);
                final sugar=context.read(bleprovider).Sugar;
                return Row(
                  children: [
                      Text(sugar.toString(),style: TextStyle(color: Colors.white),)
                    ],
                  );
                },
              ),
              )
            ],
            ),
          );
  }
}
