//
//
//
// import 'dart:async';
// import 'dart:math';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// import 'package:intl/intl.dart';
// import 'package:moving_average/moving_average.dart';
//
// import 'iirjdart/butterworth.dart';
//
// class BleProvider extends ChangeNotifier {
//
//   FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
//
//   // BleProvider()
//   // {
//   //   print("hello");
//   //   FlutterReactiveBle().statusStreten((event) {
//   //     print(event.toString());
//   //     if (event == BleStatus.ready) {
//   //       // Future.delayed(const Duration(milliseconds: 500), () {
//   //       // });
//   //     }
//   //   });
//   // }
//
//   String SERVICE_UUID          = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
//   String SERVICE_UUID2         = "cbe7d1b6-23db-11eb-adc1-0242ac120002";
//   String SERVICE_UUID3         = "74309b80-2596-11eb-adc1-0242ac120002";
//   String SERVICE_UUID4         = "63d3c17a-0896-11ec-9a03-0242ac130003";
//   String CHARACTERISTIC_UUID   = "beb5483e-36e1-4688-b7f5-ea07361b26a8";//bpm
//   String CHARACTERISTIC_UUID2  = "bfbfc788-f5bc-11ea-adc1-0242ac120002";//sp02
//   String CHARACTERISTIC_UUID3  = "c287b398-f5be-11ea-adc1-0242ac120002";//ecg
//   String CHARACTERISTIC_UUID4  = "e1d6f9a0-0b00-11eb-adc1-0242ac120002";//9ff753d2-0adc-11eb-adc1-0242ac120002 temp
//   String CHARACTERISTIC_UUID5  = "47b0d1da-1f86-11eb-adc1-0242ac120002";//recieving value from mobile 47b0d1da-1f86-11eb-adc1-0242ac120002
//   String CHARACTERISTIC_UUID6  = "9ff753d2-0adc-11eb-adc1-0242ac120002";//systolic
//   String CHARACTERISTIC_UUID7  = "f5d2f10c-243c-11eb-adc1-0242ac120002";//dyastolic
//   String CHARACTERISTIC_UUID8  = "a06df6a4-2594-11eb-adc1-0242ac120002";//ppg
//   String CHARACTERISTIC_UUID9  = "2d853ecc-eaf6-11eb-9a03-0242ac130003";//systolic set value
//   String CHARACTERISTIC_UUID10 = "7520f14a-eaf6-11eb-9a03-0242ac130003";//diastolic set value
//   String CHARACTERISTIC_UUID11 = "207b2c22-eb79-11eb-9a03-0242ac130003";//ecg_heratrate
//   String CHARACTERISTIC_UUID12 = "946b6d28-0892-11ec-9a03-0242ac130003";//Battery charge
//
//
//   late QualifiedCharacteristic char1;// bpm
//   late QualifiedCharacteristic char2;//spo2
//   late QualifiedCharacteristic char3;//ecg
//   late QualifiedCharacteristic char4;//temp
//   late QualifiedCharacteristic char5;//app command receiver
//   late QualifiedCharacteristic char6;//systolic
//   late QualifiedCharacteristic char7;// diastolic
//   late QualifiedCharacteristic char8;//ppg
//   late QualifiedCharacteristic char9;// systolic set value
//   late QualifiedCharacteristic char10;//diastolic set value
//   late QualifiedCharacteristic char11;// ecg_heartrate
//   late QualifiedCharacteristic char12;// Battery charge
//
//
//
//   late DiscoveredDevice _device;
//   DiscoveredDevice get device => _device;
//
//   String _deviceid="";
//   String get deviceid => _deviceid;
//
//   // bool _connectionstate=false;
//   // bool get connectionstate => _connectionstate;
//
//   DeviceConnectionState _connectionstate=DeviceConnectionState.disconnected;
//   DeviceConnectionState get connectionstate=>_connectionstate;
//
//   late StreamSubscription<ConnectionStateUpdate> connection;
//
//
//   @override
//   Stream<ConnectionStateUpdate> get states => _deviceConnectionController.stream;
//
//   final _deviceConnectionController = StreamController<ConnectionStateUpdate>();
//
//   late StreamSubscription<ConnectionStateUpdate> _connection;
//
//   Future<void> connected(String deviceId) async {
//
//     _connection = FlutterReactiveBle().connectToDevice(id: deviceId).listen(
//             (update) {
//           print("update");
//           print(update);
//           _connectionstate=update.connectionState;
//           notifyListeners();
//           if(_connectionstate==DeviceConnectionState.disconnected)
//           {
//
//             _deviceid="";
//
//
//             notifyListeners();
//           }
//
//           _deviceConnectionController.add(update);
//         },
//         onError: (Object e) =>print("error")
//     );
//   }
//
//   Future<void> connect(String deviceId) async {
//
//     FlutterReactiveBle().connectToAdvertisingDevice(id: deviceId,
//       withServices: [Uuid.parse(SERVICE_UUID),Uuid.parse(SERVICE_UUID2),Uuid.parse(SERVICE_UUID3),Uuid.parse(SERVICE_UUID4)],
//       prescanDuration: const Duration(seconds: 5),
//       servicesWithCharacteristicsToDiscover: {
//         Uuid.parse(SERVICE_UUID): [Uuid.parse(CHARACTERISTIC_UUID,),
//           Uuid.parse(CHARACTERISTIC_UUID2),
//           // Uuid.parse("c287b398-f5be-11ea-adc1-0242ac120002")
//           Uuid.parse(CHARACTERISTIC_UUID3),]
//
//         //   Uuid.parse(CHARACTERISTIC_UUID4),
//         //   Uuid.parse(CHARACTERISTIC_UUID5)],//service 1
//         //
//         // Uuid.parse(SERVICE_UUID2): [Uuid.parse(CHARACTERISTIC_UUID6),
//         //   Uuid.parse(CHARACTERISTIC_UUID7)],//service 2
//         //
//         // Uuid.parse(SERVICE_UUID3): [Uuid.parse(CHARACTERISTIC_UUID8),
//         //   Uuid.parse(CHARACTERISTIC_UUID9),Uuid.parse(CHARACTERISTIC_UUID10)
//         //   ,Uuid.parse(CHARACTERISTIC_UUID11)],//service 3
//         //
//         // Uuid.parse(SERVICE_UUID4): [Uuid.parse(CHARACTERISTIC_UUID12)],//service 4
//       },
//     ).listen((update){
//       print("update");
//       print(update);
//       _connectionstate=update.connectionState;
//       notifyListeners();
//       if(_connectionstate==DeviceConnectionState.disconnected)
//       {
//
//         _deviceid="";
//
//         notifyListeners();
//       }
//
//       _deviceConnectionController.add(update);
//     },
//         onError: (Object e) =>print("error")
//     );
//
//   }
//
//   void check_connectionstatus()  async
//   {
//
//     Timer.periodic(Duration(seconds: 5), (timer) async{
//       print("Started");
//       if(_connectionstate==DeviceConnectionState.connecting)
//       {
//         FlutterBluetoothSerial.instance.requestDisable();
//         _deviceid="";
//         timer.cancel();
//
//       }
//       if(_connectionstate==DeviceConnectionState.connected)
//       {
//         print("Cancel Timer");
//         timer.cancel();
//       }
//
//     });
//
//   }
//
//   Future<void> disconnect(String deviceId) async {
//     try {
//       // await _connection.cancel();
//
//     } on Exception catch (e, _) {
//     } finally {
//       // Since [_connection] subscription is terminated, the "disconnected" state cannot be received and propagated
//       _deviceConnectionController.add(
//         ConnectionStateUpdate(
//           deviceId: deviceId,
//           connectionState: DeviceConnectionState.disconnected,
//           failure: null,
//         ),
//       );
//       _connectionstate=DeviceConnectionState.disconnected;
//       notifyListeners();
//       if(_connectionstate==DeviceConnectionState.disconnected)
//       {
//         _deviceid="";
//         notifyListeners();
//       }
//     }
//   }
//
//
//   Stream<BleStatus> state=FlutterReactiveBle().statusStream;
//
//   void scan() async {
//     flutterReactiveBle.scanForDevices(withServices:[],
//         requireLocationServicesEnabled: true).listen((device){
//       if(device.name=="IQRAA TEST")
//       {
//         _device=device;
//         _deviceid=_device.id.toString();
//         flutterReactiveBle.deinitialize();
//         print("Device found");
//         notifyListeners();
//         // print(_deviceid);
//       }
//
//     });
//   }
//
//   // void connect()
//   // {
//   //   connection=flutterReactiveBle.connectToDevice(
//   //     id: _device.id,
//   //     servicesWithCharacteristicsToDiscover: {
//   //       Uuid.parse("4fafc201-1fb5-459e-8fcc-c5c9c331914b"): [Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26a8"),
//   //         Uuid.parse("bfbfc788-f5bc-11ea-adc1-0242ac120002"),
//   //         Uuid.parse("c287b398-f5be-11ea-adc1-0242ac120002"),
//   //         Uuid.parse("e1d6f9a0-0b00-11eb-adc1-0242ac120002"),
//   //         Uuid.parse("47b0d1da-1f86-11eb-adc1-0242ac120002"),],//service 1
//   //
//   //       Uuid.parse("cbe7d1b6-23db-11eb-adc1-0242ac120002"): [Uuid.parse("9ff753d2-0adc-11eb-adc1-0242ac120002"),
//   //         Uuid.parse("f5d2f10c-243c-11eb-adc1-0242ac120002")],//Serivce 2
//   //
//   //       Uuid.parse("74309b80-2596-11eb-adc1-0242ac120002"): [Uuid.parse("a06df6a4-2594-11eb-adc1-0242ac120002"),
//   //         Uuid.parse("2d853ecc-eaf6-11eb-9a03-0242ac130003"),
//   //         Uuid.parse("7520f14a-eaf6-11eb-9a03-0242ac130003"),
//   //         Uuid.parse("207b2c22-eb79-11eb-9a03-0242ac130003")],//Serivce 3
//   //
//   //       Uuid.parse("63d3c17a-0896-11ec-9a03-0242ac130003"): [Uuid.parse("946b6d28-0892-11ec-9a03-0242ac130003")],//Serivce 4
//   //
//   //     },
//   //     connectionTimeout: const Duration(seconds: 2),
//   //   ).asBroadcastStream()
//   //       .listen((connectionState) {
//   //     print(connectionState.connectionState);
//   //     _connectionstate=connectionState.connectionState;
//   //     if(_connectionstate==DeviceConnectionState.disconnected)
//   //       {
//   //         _deviceid="";
//   //         notifyListeners();
//   //       }
//   //
//   //     notifyListeners();
//   //     // Handle connection state updates
//   //   }, onError: (Object error) {
//   //     // Handle a possible error
//   //     print("error");
//   //   });
//   // }
//
//   final simpleMovingAverage = MovingAverage<num>(
//     averageType: AverageType.simple,
//     windowSize: 2,
//     partialStart: true,
//     getValue: (num n) => n,
//     add: (List<num> data, num value) => value,
//   );
//
//   Butterworth butterworth = Butterworth();
//
//   List<double> dataset = [];
//   List<double> dataset_send = [];
//   List<double> dataset_send_temp = [];
//   List<num> filteredData = [];
//   List<num> filteredData_send = [];
//   List<double> dataToFilter = [];
//   List<double> dataToFilter_send = [];
//   List<int> _resp_rate = [];
//   List<int> _resp_rate2 = [];
//   int _rr_rate = 0;
//   int _rr_rate2 = 0;
//   int rr_rate2 = 0;
//   int _last_read = 0;
//
//   bool blinkbp=false;
//   bool blinkhb=false;
//   bool blinkspo2=false;
//   bool blinktemp=false;
//   bool blinkresp=false;
//   bool deviceconnection=true;
//
//
//   late String _d;
//   String get d=>_d;
//
//   void add_patient_id(String id)
//   {
//     _d=id;
//   }
//   void clear_patient_id()
//   {
//     _d="";
//   }
//   int _heartbeat=50;
//
//   int get heartbeat => _heartbeat;
//
//   double _ecg=0;
//
//   double get ecg => _ecg;
//
//   double _ymin = -10;
//
//   double get ymin => _ymin;
//
//   double _ymax = 40;
//
//   double get ymax => _ymax;
//
//
//   int _systolic=0;
//   int _diastolic=0;
//
//   int get systolic => _systolic;
//
//   int get diastolic => _diastolic;
//
//   int _spo2=0;
//
//   int get spo2 => _spo2;
//
//   double _temperature=0;
//
//   double get temperature => _temperature;
//
//   int _respiration=0;
//
//   int get respiration => _respiration;
//
//   int _systolicset=0;
//
//   int get systolicset => _systolicset;
//
//   int _diastolicset=0;
//
//   int get diastolicset => _diastolicset;
//
//   bool _chraging=false;
//
//   bool get charging=>_chraging;
//
//   double _batteryVolt=0;
//
//   double get batteryVolt => _batteryVolt;
//
//
//   double _bmi=0;
//
//   double get bmi => _bmi;
//
//   int _globalheartrate=0;
//
//   int get globalheartrate => _globalheartrate;
//
//
//   void calculate_bmi(double height,double weight)
//   {
//     _bmi=weight/(height*height);
//     print(bmi);
//     notifyListeners();
//   }
//
//   void addVitalLimits()
//   {
//     print("vital Limits");
//     FirebaseFirestore.instance.collection("Patients").doc(d).snapshots().listen((event) {
//
//     });
//     // snapshots().listen((event) {
//     //   print(event.data());
//     // }));
//   }
//
//
//   double temp_correction=0;
//
//   int systolic_Correction=0;
//   int diastolic_Correction=0;
//
//   double BMI=15;
//   int Sugar=0;
//   String time=DateFormat.jm().format(DateTime.now());
//
//
//   void getservices() async
//   {
//     await Future.delayed(Duration(milliseconds: 100),(){
//
//       char1=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID),
//           serviceId: Uuid.parse(SERVICE_UUID), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char1).listen((event) {
//         if(event[0]==0 && (_spo2!=0 || _systolic!=0 || _diastolic!=0))
//         {
//           _heartbeat=_heartbeat;
//         }
//         else
//         {
//           _heartbeat = event[0];
//         }
//         // print(_heartbeat);
//         notifyListeners();
//       });
//     });
//     await Future.delayed(Duration(milliseconds: 150),(){
//
//       char2=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID2),
//           serviceId: Uuid.parse(SERVICE_UUID), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char2).listen((event) {
//         if(event[0]==100)
//         {
//           _spo2=99;
//         }
//         else
//         {
//           _spo2 = event[0].toInt();
//         }
//         // print(_heartbeat);
//         notifyListeners();
//       });
//     });
//     await Future.delayed(Duration(milliseconds: 200),(){
//
//       char3=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID3),
//           serviceId: Uuid.parse(SERVICE_UUID), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char3).listen((event) {
//         // _ecg=event[0].toDouble();
//
//         butterworth.bandStop(2, 200, 250, 20);
//         // butterworth.bandStop(1, 210, 240, 5);
//
//         if (event[0].toDouble() > 100) {
//           _ecg = event[0].toDouble() - 256;
//           // print(_ecg);
//         }
//         else {
//           _ecg = event[0].toDouble();
//           // print(_ecg);
//         }
//         dataset.add(_ecg);
//
//         dataset_send.add(ecg);
//
//         // print("ecg");
//         filteredData = simpleMovingAverage(dataset);
//         // filteredData_send = simpleMovingAverage(dataset_send);
//         //**butterworth.highPass(2, 2000, 50, 7);
//
//
//         // print(filteredData.last);
//         dataToFilter =
//             filteredData.map((e) => butterworth.filter(e.toDouble())).toList();
//
//         // dataToFilter_send=filteredData_send.map((e) => butterworth.filter(e.toDouble())).toList();
//         // dataToFilter =
//         //     filteredData.map((e) =>e.toDouble()).toList();
//         if (dataset.length > 300) {
//           dataset.removeRange(0, 4);
//           // dataset.clear();
//         }
//         if (filteredData.length > 300) {
//           filteredData.removeRange(0, 4);
//           // filteredData.clear();
//         }
//         if (dataToFilter.length > 300) {
//           // providerContainer.read(ecgpro).addecg(dataToFilter);
//           _ymax = dataToFilter.reduce(max)+25;
//           _ymin = dataToFilter.reduce(min)-25;
//           // dataToFilter.clear();
//           dataToFilter.removeRange(0, 4);
//
//           // notifyListeners();
//         }
//
//         notifyListeners();
//       });
//     });
//
//     await Future.delayed(Duration(milliseconds: 250),(){
//       char4=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID4),
//           serviceId: Uuid.parse(SERVICE_UUID), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char4).listen((event) {
//         if(event[0].toDouble()/5==26.6)
//         {
//           _temperature=0.0;
//         }
//         else
//         {
//           _temperature=event[0].toDouble()/5;
//         }
//         // print(_temperature);
//         notifyListeners();
//       });
//     });
//
//     await Future.delayed(Duration(milliseconds: 300),(){
//       char6=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID6),
//           serviceId: Uuid.parse(SERVICE_UUID2), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char6).listen((event) {
//         _systolic=event[0];
//         // print(_heartbeat);
//         notifyListeners();
//       });
//     });
//
//     await Future.delayed(Duration(milliseconds: 350),(){
//       char7=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID7),
//           serviceId: Uuid.parse(SERVICE_UUID2), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char7).listen((event) {
//         _diastolic=event[0];
//         // print(_heartbeat);
//         notifyListeners();
//       });
//     });
//
//     await Future.delayed(Duration(milliseconds: 350),(){
//       char8=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID8),
//           serviceId: Uuid.parse(SERVICE_UUID3), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char8).listen((event) {
//         _respiration=event[0];
//         // print("Respiration");
//         // print(event[0]);
//         notifyListeners();
//       });
//     });
//
//     await Future.delayed(Duration(milliseconds: 350),(){
//       char9=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID9),
//           serviceId: Uuid.parse(SERVICE_UUID3), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char9).listen((event) {
//         _systolicset=event[0];
//         // print(_heartbeat);
//         notifyListeners();
//       });
//     });
//
//     await Future.delayed(Duration(milliseconds: 400),(){
//       char10=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID10),
//           serviceId: Uuid.parse(SERVICE_UUID3), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char10).listen((event) {
//         _diastolicset=event[0];
//         // print(_heartbeat);
//         notifyListeners();
//       });
//     });
//
//     await Future.delayed(Duration(milliseconds: 450),(){
//       char11=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID11),
//           serviceId: Uuid.parse(SERVICE_UUID4), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char11).listen((event) {
//         // print("Global HeartRate");
//         // print(event[0]);
//         _globalheartrate=event[0];
//         notifyListeners();
//       });
//     });
//
//
//     await Future.delayed(Duration(milliseconds: 500),(){
//       char12=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID12),
//           serviceId: Uuid.parse(SERVICE_UUID4), deviceId:  deviceid );
//       flutterReactiveBle.subscribeToCharacteristic(char12).listen((event) {
//         _batteryVolt=event[0]*0.018834;
//         // print(_heartbeat);
//         notifyListeners();
//       });
//     });
//
//   }
//
//   late StreamSubscription<List<int>> vitals;
//   late StreamSubscription<List<int>> vitalecg;
//
//   Future<void> getservices2() async
//   {
//     print("Services 2");
//
//     char1=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID),
//         serviceId: Uuid.parse(SERVICE_UUID), deviceId:  deviceid );
//     vitals=flutterReactiveBle.subscribeToCharacteristic(char1).listen((event) {
//       print(event);
//       if(event[0]==0 && (_spo2!=0 || _systolic!=0 || _diastolic!=0))
//       {
//         _heartbeat=_heartbeat;
//         notifyListeners();
//       }
//       else
//       {
//         _heartbeat = event[0];
//         notifyListeners();
//       }
//
//       if(event[1]==100)
//       {
//         _spo2=99;
//         notifyListeners();
//       }
//       else
//       {
//         _spo2 = event[1].toInt();
//         notifyListeners();
//       }
//
//       if(event[2].toDouble()/5==26.6)
//       {
//         _temperature=0.0;
//         notifyListeners();
//       }
//       else
//       {
//         _temperature=event[2].toDouble()/5;
//         notifyListeners();
//       }
//       _systolic=event[3];
//       _diastolic=event[4];
//       _respiration=event[5];
//       _systolicset=event[6];
//       _diastolicset=event[7];
//       _globalheartrate=event[8];
//       _batteryVolt=event[9]*0.018834;
//
//
//       print(_batteryVolt);
//       notifyListeners();
//     });
//
//
//     char3 = QualifiedCharacteristic(
//         characteristicId: Uuid.parse(CHARACTERISTIC_UUID3),
//         serviceId: Uuid.parse(SERVICE_UUID), deviceId: deviceid);
//     vitalecg=flutterReactiveBle.subscribeToCharacteristic(char3).listen((event) {
//       // _ecg=event[0].toDouble();
//
//       butterworth.bandStop(2, 200, 250, 20);
//       // butterworth.bandStop(1, 210, 240, 5);
//
//       if (event[0].toDouble() > 100) {
//         _ecg = event[0].toDouble() - 256;
//         // print(_ecg);
//       }
//       else {
//         _ecg = event[0].toDouble();
//         // print(_ecg);
//       }
//       dataset.add(_ecg);
//
//       dataset_send.add(ecg);
//
//       // print("ecg");
//       filteredData = simpleMovingAverage(dataset);
//       // filteredData_send = simpleMovingAverage(dataset_send);
//       //**butterworth.highPass(2, 2000, 50, 7);
//
//
//       // print(filteredData.last);
//       dataToFilter =
//           filteredData.map((e) => butterworth.filter(e.toDouble())).toList();
//
//       // dataToFilter_send=filteredData_send.map((e) => butterworth.filter(e.toDouble())).toList();
//       // dataToFilter =
//       //     filteredData.map((e) =>e.toDouble()).toList();
//       if (dataset.length > 300) {
//         dataset.removeRange(0, 4);
//         // dataset.clear();
//       }
//       if (filteredData.length > 300) {
//         filteredData.removeRange(0, 4);
//         // filteredData.clear();
//       }
//       if (dataToFilter.length > 300) {
//         // providerContainer.read(ecgpro).addecg(dataToFilter);
//         _ymax = dataToFilter.reduce(max) + 25;
//         _ymin = dataToFilter.reduce(min) - 25;
//         // dataToFilter.clear();
//         dataToFilter.removeRange(0, 4);
//
//         // notifyListeners();
//       }
//
//       notifyListeners();
//     });
//
//   }
//
//   void WriteData(int sys,int dia) async
//   {
//     // Uint8List.fromList([10])
//     char5=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID5),
//         serviceId: Uuid.parse(SERVICE_UUID), deviceId: deviceid);
//     await flutterReactiveBle.writeCharacteristicWithoutResponse(char5, value: [sys,dia]);
//     print("send");
//   }
//
//   void writedata2(int sys,int dia)
//   {
//     char5=QualifiedCharacteristic(characteristicId: Uuid.parse(CHARACTERISTIC_UUID2),
//         serviceId: Uuid.parse(SERVICE_UUID), deviceId: deviceid);
//     flutterReactiveBle.writeCharacteristicWithoutResponse(char5, value: [sys,dia]);
//     print("send");
//   }
//
//   bool timer_start=false;
//
//   Future<void> start_sending_to_cloud()  async
//   {
//
//     Timer.periodic(Duration(seconds: 30), (timer) async{
//       // print("Started _sending");
//       if (timer_start) {
//         // print("Packet_send");
//         DataUpload(device.id.toString(),heartbeat.toDouble(),spo2.toDouble(),temperature.toDouble(),systolic,diastolic,dataset_send,respiration,Sugar,bmi);
//         // print(dataset_send.length);
//         dataset_send.clear();
//
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
//
//   Future<void> DataUpload(String _device,double _heartrate,double _spo2,double _temp,int _sys,int _dys,List<double> _ecg,int respiration,int sugar,double _bmi) async
//   {
//     // String _device=device.identifier.toString();
//     String patientid=d;
//     await FirebaseFirestore.instance.collection("Devices/$_device/Healthparameters2").add({
//       'Datetime':DateTime.now(),
//       "heartrate":_heartrate,
//       "PatientsId":patientid,
//       "SPO2":_spo2,
//       'temperature':_temp,
//       'Sys':_sys,
//       'Dys':_dys,
//       'ecg':_ecg,
//       'rr':respiration,
//       'glucose':sugar,
//       'bmi':_bmi,
//       'time':time
//     });
//   }
//
//
// }