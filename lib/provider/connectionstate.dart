import 'package:flutter/foundation.dart';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';



class Connectionstates extends ChangeNotifier
{
  final DeviceConnectionState deviceconnectionstate;
  Connectionstates({required this.deviceconnectionstate});
}