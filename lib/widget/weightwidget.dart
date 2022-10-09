

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';



class weightwidget extends StatefulWidget {

  weightwidget(this.id);
  String id;

  @override
  _weightwidgetState createState() => _weightwidgetState();
}

class _weightwidgetState extends State<weightwidget> {
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
              title: Text('Enter the Weight'),
              content: SingleChildScrollView(
                child: Container(
                  child: TextField(
                    keyboardType:TextInputType.number,
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
                        context.read(patientProvider).update_weight(widget.id,double.parse(_textFieldController.text) );
                        context.read(patientProvider).add_weight(double.parse(_textFieldController.text));
                        context.read(bleprovider).calculate_bmi(context.read(patientProvider).height,context.read(patientProvider).weight);
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
            title: Text("Weight",style: TextStyle(color: Colors.white),),
            subtitle: Consumer(
              builder: (context,watch,child){
                final patientinfo=watch(patientAdmitted);
                return patientinfo.when(
                  data: (data){
                    return Row(
                        children:[
                          data.docs.first.get("Weight")==0.0?
                          Text("- -",style: TextStyle(color: Colors.white),)
                              :Text(data.docs.first.get("Weight").toString(),style: TextStyle(color: Colors.white),),
                          Text(" Kg",style: TextStyle(color: Colors.white),),
                        ]
                    );
                  },
                  loading: ()=>CircularProgressIndicator(),

                  error: (_,__)=>Container(
                    child: Text("OOPS"),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
