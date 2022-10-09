


import 'package:flutter/foundation.dart';

class Battery extends ChangeNotifier
{
  double voltage;
  Battery(this.voltage);
}

class Battery_charging extends ChangeNotifier
{
  bool charging;
  Battery_charging(this.charging);
}