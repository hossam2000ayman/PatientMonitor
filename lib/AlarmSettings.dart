

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_beep/flutter_beep.dart';



final alarmprovider=Provider((ref)=>AlarmSettings());

class AlarmSettings with ChangeNotifier
{
 
  bool Hbalarm=false;
  bool Spo2alarm=false;
  bool Tempalarm=false;
  bool Respalarm=false;
  bool Bpalarm=false;

  bool canceltimer=false;

  bool _alarmalreadyplaying=false;






  Future<void> soundAlarm()  async
  {

    Timer.periodic(Duration(seconds: 2), (timer) {
      // print("_alarmalreadyplaying");
      // print(_alarmalreadyplaying);
          if (_alarmalreadyplaying) {
            FlutterBeep.playSysSound(97);
          }
          if(canceltimer)
            {
              timer.cancel();
            }
      });
    
  }


  Future<void> playAlarm()  async
  {

    if((Hbalarm||Spo2alarm||Tempalarm||Respalarm||Bpalarm)&_alarmalreadyplaying==false)
      {

        _alarmalreadyplaying=true;
        // print("Sound Alarm");

      }
    if(Hbalarm==false && Spo2alarm==false && Tempalarm==false && Respalarm==false && Bpalarm==false)
      {
        // print("Stop Alarm");
        _alarmalreadyplaying=false;


      }


  }

  int _alarmTurnOff=0;
  int get  alarmTurnOff=>_alarmTurnOff;

  void startAlarmTimer()
  {
    Timer.periodic(Duration(seconds: 5), (timer) {
      _alarmTurnOff=1;

      // print("alarmturnOnn");
      if(canceltimer)
      {
        timer.cancel();
      }
      notifyListeners();
    });
    notifyListeners();
  }

  void resetAlarm()
  {

    _alarmTurnOff=0;
    // print(_alarmTurnOff);
    notifyListeners();
  }


  bool batterlow=false;

  bool canceltimer_battery=false;



  Future<void> soundAlarm_battery()  async
  {

    Timer.periodic(Duration(seconds: 2), (timer) {
      // print("_alarmalreadyplaying");
      // print(_alarmalreadyplaying);
      if (batterlow) {
        FlutterBeep.playSysSound(87);
      }
      if(canceltimer_battery)
      {
        timer.cancel();
      }
    });

  }

}