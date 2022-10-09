//
//
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';
//
// class BleProvider extends ChangeNotifier
// {
//
//   FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
//
//   late QualifiedCharacteristic char1;// state
//   late QualifiedCharacteristic char2;//weight_data
//   late QualifiedCharacteristic char3;//_counter
//   // late QualifiedCharacteristic char4;//weight convert
//   late QualifiedCharacteristic char5;//app command receiver
//   // late QualifiedCharacteristic char17;//counter conert
//
//
//   late QualifiedCharacteristic char6;//weight limit send
//   late QualifiedCharacteristic char7;// light limit send
//
//
//
//
//   late StreamSubscription<List<int>> liftstate;
//   late StreamSubscription<List<int>> weight_data;
//   late StreamSubscription<List<int>> counter;
//
//   late StreamSubscription<List<int>> weight_limit_send;
//   late StreamSubscription<List<int>> light_limit_send;
//
//   final Uuid serviceId = Uuid.parse('4fafc201-1fb5-459e-8fcc-c5c9c331914b');
//
//   String SERVICE_UUID      =   "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
//   String SERVICE_UUID2      =   "cbe7d1b6-23db-11eb-adc1-0242ac120002";
//
//   String CHARACTERISTIC_UUID  ="beb5483e-36e1-4688-b7f5-ea07361b26a8";//STATE
//   String CHARACTERISTIC_UUID2 ="bfbfc788-f5bc-11ea-adc1-0242ac120002";//weight_data
//   String CHARACTERISTIC_UUID3 ="c287b398-f5be-11ea-adc1-0242ac120002";//_counter
//
//   String CHARACTERISTIC_UUID5 ="47b0d1da-1f86-11eb-adc1-0242ac120002";//app command receiver
//   String CHARACTERISTIC_UUID6 ="9ff753d2-0adc-11eb-adc1-0242ac120002";//weight_limit_send
//   String CHARACTERISTIC_UUID7 ="f5d2f10c-243c-11eb-adc1-0242ac120002";//light_limit_send
//
//
//   late StreamSubscription<ConnectionStateUpdate> _connection;
//
//
//   BleProvider()
//   {
//     print("BleManager create client");
//     FlutterReactiveBle().statusStream.listen((event) {
//       print(event.toString());
//       if (event == BleStatus.ready) {
//         Future.delayed(const Duration(milliseconds: 500), () {
//           scan();
//         });
//       }
//     });
//   }
//
//   Stream<BleStatus> state=FlutterReactiveBle().statusStream;
//
//   late String deviceid;
//
//   late StreamSubscription<DiscoveredDevice> discoverd_devices;
//
//   late List<DiscoveredDevice> device_discovered;
//
//   bool _discovered=false;
//
//   bool get discovered=>_discovered;
//
//   bool _startdiscovering=false;//Icon button
//
//   bool get startdiscovering=>_startdiscovering;
//
//   bool timer_start=false;
//
//   void scan() async
//   {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _startdiscovering=true;
//     print("_startdiscovering");
//     print(_startdiscovering);
//     print("Scannig");
//     print(prefs.get("device id"));
//
// // Here you can write your code
//     discoverd_devices=flutterReactiveBle.scanForDevices(withServices:[],requireLocationServicesEnabled: true).listen((device)
//     {
//       deviceid=device.id.toString();
//       print(deviceid.length);
//       print(prefs.get("device id").toString().length);
//       //code for handling results
//       if(device.id.toString()==prefs.get("device id").toString())
//       {
//         // device_discovered.add(device);
//         _discovered=true;
//         _startdiscovering=false;
//
//         print("_startdiscovering");
//         print(_startdiscovering);
//
//         notifyListeners();
//
//         print(device.id.toString());
//         discoverd_devices.cancel();
//
//         Future.delayed(const Duration(seconds: 5), () {
//           connect();
//         });
//       }
//
//     });
//   }
//
//   bool _connectionstaus=false;
//
//   bool get connectionstaus=>_connectionstaus;
//
//   bool _connecting=false;
//
//   bool get connecting=>_connecting;
//
//   void connect() async
//   {
//     _connecting=true;
//     _connection=  flutterReactiveBle.connectToAdvertisingDevice(
//       id: deviceid,
//       withServices: [
//         //   Uuid.parse("4fafc201-1fb5-459e-8fcc-c5c9c331914b"),Uuid.parse("cbe7d1b6-23db-11eb-adc1-0242ac120002")
//         // ,Uuid.parse("74309b80-2596-11eb-adc1-0242ac120002"),Uuid.parse("63d3c17a-0896-11ec-9a03-0242ac130003")
//         // ,Uuid.parse("87781ede-2e46-11ec-8d3d-0242ac130003")
//       ],
//       prescanDuration: const Duration(seconds: 10),
//       servicesWithCharacteristicsToDiscover: {
//         Uuid.parse("4fafc201-1fb5-459e-8fcc-c5c9c331914b"): [Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26a8"),
//           Uuid.parse("bfbfc788-f5bc-11ea-adc1-0242ac120002"),
//           // Uuid.parse("c287b398-f5be-11ea-adc1-0242ac120002")
//           Uuid.parse("e1d6f9a0-0b00-11eb-adc1-0242ac120002"),Uuid.parse("47b0d1da-1f86-11eb-adc1-0242ac120002")],//service 1
//
//         Uuid.parse("cbe7d1b6-23db-11eb-adc1-0242ac120002"): [Uuid.parse("9ff753d2-0adc-11eb-adc1-0242ac120002"),
//           Uuid.parse("f5d2f10c-243c-11eb-adc1-0242ac120002")],//service 2
//
//         // Uuid.parse("74309b80-2596-11eb-adc1-0242ac120002"): [Uuid.parse("a06df6a4-2594-11eb-adc1-0242ac120002"),
//         //   Uuid.parse("2d853ecc-eaf6-11eb-9a03-0242ac130003"),Uuid.parse("7520f14a-eaf6-11eb-9a03-0242ac130003")
//         //   ,Uuid.parse("207b2c22-eb79-11eb-9a03-0242ac130003")],//service 3
//         //
//         // Uuid.parse("63d3c17a-0896-11ec-9a03-0242ac130003"): [Uuid.parse("946b6d28-0892-11ec-9a03-0242ac130003"),
//         //   Uuid.parse("b08e9132-2e4a-11ec-8d3d-0242ac130003")],//service 4
//         //
//         // Uuid.parse("87781ede-2e46-11ec-8d3d-0242ac130003"): [Uuid.parse("221e266e-2e46-11ec-8d3d-0242ac130003"),
//         //   Uuid.parse("396feabe-2e46-11ec-8d3d-0242ac130003"),Uuid.parse("4e6476c4-2e46-11ec-8d3d-0242ac130003")
//         //   ,Uuid.parse("62dfcd56-2e46-11ec-8d3d-0242ac130003")],//service 5
//
//
//       },
//       connectionTimeout: const Duration(seconds:  5),
//     ).listen((connectionState)  {
//       print(connectionState.connectionState.toString());
//       if(connectionState.connectionState==DeviceConnectionState.connected)
//       {
//         _connectionstaus=true;
//         _connecting=false;
//         getservices();
//         timer_start=true;
//         start_sending_to_cloud();
//         notifyListeners();
//       }
//       else if(connectionState.connectionState==DeviceConnectionState.disconnected)
//       {
//         _connectionstaus=false;
//         timer_start=false;
//         disconnect();
//         notifyListeners();
//       }
//       // Handle connection state updates
//     },onError: (dynamic error) {
//
//       _discovered=false;
//       device_discovered.clear();
//     });
//   }
//
//
//
//   Future<void> disconnect() async
//   {
//     try
//     {
//       await liftstate.cancel();
//       await weight_data.cancel();
//       await counter.cancel();
//
//       await weight_limit_send.cancel();
//       await light_limit_send.cancel();
//
//       _connection.cancel();
//       // device_discovered.clear();
//       _discovered=false;
//     }on Exception catch (e, _) {
//       print("Error disconnecting from a device: $e");
//     }
//
//   }
//
//
//   int _state=0;
//   int get state_of_lift=>_state;
//
//   double _weight=0;
//   double get weight=>_weight;
//
//   int _counte=0;
//   int get counte=>_counte;
//
//   int _weight_convert=0;
//   int get weight_converter=>_weight_convert;
//
//   int _counter_convert=0;
//   int get counter_converter=>_counter_convert;
//
//   double _weight_limit_send=0;
//   double get weight_limit_sender=>_weight_limit_send;
//
//   double _light_limit_send=0;
//   double get light_limit_sender=>_light_limit_send;
//
//   int _limit_up=0;
//   int get limitup=>_limit_up;
//
//   int _limit_down=0;
//   int get limitdown=>_limit_down;
//
//   int _pushup=0;
//   int get pushup=>_pushup;
//
//   int _pushdown=0;
//   int get pushdown=>_pushdown;
//
//   int _emergency=0;
//   int get emergencyswitch=>_emergency;
//
//   int _bottomplate=0;
//   int get bottomplateswitch=>_bottomplate;
//
//   int _door=0;
//   int get doorswitch=>_door;
//
//
//
//
//
//   void getservices() async
//   {
//     await Future.delayed(Duration(milliseconds: 100),(){
//
//       char1=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID),
//           serviceId: Uuid.parse(SERVICE_UUID), deviceId:  deviceid );
//       liftstate= flutterReactiveBle.subscribeToCharacteristic(char1).listen((event) {
//         // print("State");
//         // print(event);
//         _state=event[0];
//         _limit_up=event[1];
//         _limit_down=event[2];
//         _pushup=event[3];
//         _pushdown=event[4];
//         _emergency=event[5];
//         _bottomplate=event[6];
//         _door=event[7];
//         notifyListeners();
//       });
//     });
//
//     await Future.delayed(Duration(milliseconds: 200),(){
//
//       char2=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID2),
//           serviceId: Uuid.parse(SERVICE_UUID), deviceId: deviceid);
//       weight_data=flutterReactiveBle.subscribeToCharacteristic(char2).listen((event) {
//         // print("weight");
//         // print(event);
//         _weight=event[0]/100+(256*event[1]);
//         // print(_weight);
//         notifyListeners();
//       });
//     });
//
//     await Future.delayed(Duration(milliseconds: 300),(){
//       char3=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID3),
//           serviceId: Uuid.parse(SERVICE_UUID), deviceId: deviceid);
//       counter=flutterReactiveBle.subscribeToCharacteristic(char3).listen((event) {
//         // print("_counter");
//         // print(event);
//         _counte=event[0]+(256*event[1]);
//         notifyListeners();
//       });
//     });
//
//
//     await Future.delayed(Duration(milliseconds: 600),(){
//       char6=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID6),
//           serviceId: Uuid.parse(SERVICE_UUID2), deviceId: deviceid);
//       weight_limit_send= flutterReactiveBle.subscribeToCharacteristic(char6).listen((event) {
//         // print("weight limit send");
//         // print(event);
//         _weight_limit_send=(event[0]+(256*event[1]))/100;
//         // print(_weight_limit_send);
//         notifyListeners();
//       });
//     });
//
//     await Future.delayed(Duration(milliseconds: 700),(){
//       char7=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID7),
//           serviceId: Uuid.parse(SERVICE_UUID2), deviceId: deviceid);
//       light_limit_send= flutterReactiveBle.subscribeToCharacteristic(char7).listen((event) {
//         // print("light limit send");
//         // print(event);
//         _light_limit_send=(event[0]+(256*event[1]))/100;
//         // print(_light_limit_send);
//         notifyListeners();
//       });
//     });
//
//
//
//   }
//   // late QualifiedCharacteristic char5;
//
//   void write(int i) async
//   {
//     // 1 for up and 2 for doen
//     char5=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID5),
//         serviceId: Uuid.parse(SERVICE_UUID), deviceId: deviceid);
//
//     await flutterReactiveBle.writeCharacteristicWithoutResponse(char5, value: [i]);
//   }
//
//   void write_limit(double i,int j) async//i the enterd value j is for identifying weight limit or light limit
//       {
//     // 1 for up and 2 for doen
//
//     int k=(i*10).toInt();
//     int x3=k%10;
//     int x2=k~/10%10;
//     int x1=k~/100%10;
//     print(x1);
//     print(x2);
//     print(x3);
//     char5=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID5),
//         serviceId: Uuid.parse(SERVICE_UUID), deviceId: deviceid);
//
//     await flutterReactiveBle.writeCharacteristicWithoutResponse(char5, value: [(x1*10+x2),x3,j]);
//   }
//
//
//
//   Future<void> start_sending_to_cloud()  async
//   {
//
//     Timer.periodic(Duration(seconds: 30), (timer) async{
//       print("Started _sending");
//       if (timer_start) {
//         DataUpload();
//       }
//       else
//       {
//         print("stopped_sending");
//         timer.cancel();
//       }
//     });
//
//   }
//
//   Future<void> DataUpload() async
//   {
//     // String _device=device.identifier.toString();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String uid=prefs.get("uid").toString();
//     // await FirebaseFirestore.instance.collection("User/$uid/LiftData").doc(deviceid).update({
//     //   'No of Travel':_counte,
//     //   'Weight':_weight,
//     //   'weightlimit':_weight_limit_send,
//     //   'lightlimit':_light_limit_send,
//     //   'bottomplate':_bottomplate,
//     //   'door':_door,
//     //   'emergencystop':_emergency,
//     //   'limitdown':_limit_down,
//     //   'limitup':_limit_up,
//     //   'pushdown':_pushdown,
//     //   'pushup':_pushup,
//     //   'state':_state,
//     //   'DateTime':DateTime.now(),
//     //   'time':DateFormat.jm().format(DateTime.now()).toString()
//     // });
//     await FirebaseFirestore.instance.collection("Devices").doc(deviceid).update({
//       'No of Travel':_counte,
//       'Weight':_weight,
//       'weightlimit':_weight_limit_send,
//       'lightlimit':_light_limit_send,
//       'bottomplate':_bottomplate,
//       'door':_door,
//       'emergencystop':_emergency,
//       'limitdown':_limit_down,
//       'limitup':_limit_up,
//       'pushdown':_pushdown,
//       'pushup':_pushup,
//       'state':_state,
//       'DateTime':DateTime.now(),
//       'time':DateFormat.jm().format(DateTime.now()).toString()
//     });
//
//   }
//
//   @override
//   Future<void> dispose() async {
//     // TODO: implement dispose
//     super.dispose();
//     await liftstate.cancel();
//     await weight_data.cancel();
//     await counter.cancel();
//
//     await light_limit_send.cancel();
//
//     await discoverd_devices.cancel();
//     await _connection.cancel();
//     device_discovered.clear();
//     deviceid="";
//     _discovered=false;
//   }
//
// }

// Future.delayed(Duration(seconds: 1),(){
//   final connectionstates=context.read(bleprovider).connectionstate;
//   print(connectionstates);
//
//   context.read(bleprovider).deviceconnection=false;
//   if(connectionstates==DeviceConnectionState.connected)
//   {
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context)  {
//       // return DeviceScreen(device: r.device,);
//       // return PatientDetail();
//       return CurrenPatient();
//     }));
//
//   }
//   else
//     {
//       return;
//     }
//   });