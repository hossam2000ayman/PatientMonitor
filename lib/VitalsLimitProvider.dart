

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient_monitor_nullsafety/main.dart';

final vitalprovider=ChangeNotifierProvider((ref)=>VitalsLimit());

class VitalsLimit with ChangeNotifier
{

  VitalsLimit()
  {
    // print("vitalsLimit");
    // _sys_correction=10;
    // print(patient_id);
    // CollectionReference doc=FirebaseFirestore.instance.collection("Patients");
    // print(doc.id);
   // print( FirebaseFirestore.instance.doc("Patients/$patient_id"));
    // doc("Patients/$patient_id").snapshots().listen((event) {
    //   _hbMax=event[0].get("hbmax");
    //   print("_hbMax");
    //   print(_hbMax);
    // });
  }

  String patient_id="";




  int _sys_correction=0;
  int get sys_correction=>_sys_correction;

  void add_syscorretcion(int val)
  {
    _sys_correction=val;
    notifyListeners();
  }

  int _dys_correction=0;
  int get dys_correction=>_dys_correction;

  void add_diacorretcion(int val)
  {
    _dys_correction=val;
    notifyListeners();
  }

  double _sysMax=110;
  double get sysMax=>_sysMax;

  void add_sysMax(double val)
  {
    _sysMax=val;
    notifyListeners();
  }

  double _sysMin=0;
  double get sysMin=>_sysMin;

  void add_sysMin(double val)
  {
    _sysMin=val;
    notifyListeners();
  }


  double _dysMax=120;
  double get dysMax=>_dysMax;

  void add_dysMax(double val)
  {
    _dysMax=val;
    notifyListeners();
  }

  double _dysMin=100;
  double get dysMin=>_dysMin;

  void add_dysMin(double val)
  {
    _dysMin=val;
    notifyListeners();
  }

  int _hbMax=150;
  int get hbMax=>_hbMax;

  void add_hbMax(int val)
  {
    _hbMax=val;
    notifyListeners();


  }

  int _hbMin=50;
  int get hbMin=>_hbMin;

  void add_hbMin(int val)
  {
    _hbMin=val;
    notifyListeners();
    

  }

  int _spo2Min=50;
  int get spo2Min=>_spo2Min;

  void add_spo2Min(int val)
  {
    _spo2Min=val;
    notifyListeners();

  }

  double _tpMax=39.0;
  double get tpMax=>_tpMax;

  void add_tpMax(double val)
  {
    _tpMax=val;
    notifyListeners();

  }

  double _tpMin=34;
  double get tpMin=>_tpMin;

  void add_tpMin(double val)
  {
    _tpMin=val;
    notifyListeners();

  }

  int _rsMax=25;
  int get rsMax=>_rsMax;

  void add_rsMax(int val)
  {
    _rsMax=val;
    notifyListeners();

  }

  int _rsMin=9;
  int get rsMin=>_rsMin;

  void add_rsMin(int val)
  {
    _rsMin=val;
    notifyListeners();

  }

  double _tempCorrection=0;
  double get tempCorrection=>_tempCorrection;

  void add_tempcorrection(double val)
  {
    _tempCorrection=val;
    notifyListeners();

  }

  Future<void> vitalfromcloud() async
  {
    await FirebaseFirestore.instance.collection("Patients").doc(patient_id).
    snapshots().listen((event) {
      // _hbMax=event.get("hbmax");
      // print(_hbMax);
      add_hbMax(event.get("hbmax"));
      // _hbMin=event.get("hbmin");
      // print(_hbMin);
      add_hbMin(event.get("hbmin"));
      // _spo2Min=event.get("spo2min");
      // print(_spo2Min);
      add_spo2Min(event.get("spo2min"));
      // _tpMax==double.parse(event.get("tempmax").toString());
      // print(_tpMax);
      add_tpMax(double.parse(event.get("tempmax").toString()));
      // _tpMin=double.parse(event.get("tempmin").toString());
      // print(_tpMin);
      add_tpMin(double.parse(event.get("tempmin").toString()));
      // _rsMax=event.get("respmax");
      // print(_rsMax);
      add_rsMax(event.get("respmax"));
      // _rsMin=event.get("respmin");
      // print(_rsMin);
      add_rsMin(event.get("respmin"));
      // _sysMax=double.parse(event.get("sysmax").toString());
      // print(_sysMax);
      add_sysMax(double.parse(event.get("sysmax").toString()));
      // _sysMin==double.parse(event.get("sysmin").toString());
      // print(_sysMin);
      add_sysMin(double.parse(event.get("sysmin").toString()));
      // _dysMax==double.parse(event.get("dysmax").toString());
      add_dysMax(double.parse(event.get("dysmax").toString()));
      // _dysMin==double.parse(event.get("dysmin").toString());
      add_dysMin(double.parse(event.get("dysmin").toString()));
      // print(_dysMin);
      notifyListeners();
    });

  }

  Future<void> updateVitaltoCloud() async
  {
   await FirebaseFirestore.instance.collection("Patients").doc(patient_id).update({
      "hbmax":_hbMax,
      "hbmin":_hbMin,
      "spo2min":_spo2Min,
      "tempmax":_tpMax,
      "tempmin":_tpMin,
      "respmax":_rsMax,
      "respmin":_rsMin,
      "sysmax":_sysMax,
      "sysmin":_sysMin,
      "dysmax":_dysMax,
      "dysmin":dysMin
    });
  }


}