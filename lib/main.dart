

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:patient_monitor_nullsafety/BluetoothProvider.dart';
import 'package:patient_monitor_nullsafety/provider/BMI.dart';
import 'package:patient_monitor_nullsafety/provider/batteryprovider.dart';
import 'package:patient_monitor_nullsafety/provider/blink.dart';
import 'package:patient_monitor_nullsafety/provider/connectionstate.dart';
import 'package:patient_monitor_nullsafety/provider/ecgprovider.dart';
import 'package:patient_monitor_nullsafety/provider/hearbeat.dart';
import 'package:patient_monitor_nullsafety/provider/patientprovider.dart';
import 'package:patient_monitor_nullsafety/provider/respirationprovider.dart';
import 'package:patient_monitor_nullsafety/provider/scan.dart';
import 'package:patient_monitor_nullsafety/provider/spo2provider.dart';
import 'package:patient_monitor_nullsafety/provider/systolicprovider.dart';
import 'package:patient_monitor_nullsafety/provider/temperatureprovider.dart';
import 'package:patient_monitor_nullsafety/screens/auth.dart';
import 'package:patient_monitor_nullsafety/screens/connecting.dart';
import 'FirebaseProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authServicesProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService(ref.read(firebaseAuthProvider));
});

final authStateProvider = StreamProvider.autoDispose<User?>((ref) {
  return ref.watch(authServicesProvider).authStateChange;
});

final firebasefirestoreProvider=Provider<FirebaseFirestore>((ref){
  return FirebaseFirestore.instance;
});


final device=Provider<DiscoveredDevice>((ref){
  final _device=ref.watch(bleprovider).device;
  return _device;
});


final patientProvider=Provider<Patient>((ref){
  return Patient(ref.watch(deviceid),ref.read(firebasefirestoreProvider));
});

final deviceid=Provider<String>((ref){
  final _deviceid=ref.watch(bleprovider);
  return _deviceid.deviceid;
});

final deviceid2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(deviceid);
  return  Scan(hbs);
} );

final patientAdmitted=StreamProvider.autoDispose<QuerySnapshot>((ref){
  return ref.watch(patientProvider).patientdetails;
});

// final usersignedinstatus = StreamProvider.autoDispose((ref) => AuthenticationService().Authschange);
final bleprovider=ChangeNotifierProvider((ref)=>BleProvider());
// final scaned=ChangeNotifierProvider((ref)=>Scan());
final bluetoothstatus=StreamProvider.autoDispose((ref)=>BleProvider().state);



final connectonstate=Provider<DeviceConnectionState>((ref) {
  final constate=ref.watch(bleprovider);
  return  constate.connectionstate;
} );

final connectonstate2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(connectonstate);
  return  Connectionstates(deviceconnectionstate: hbs);
} );



final heartbeats=Provider<int>((ref) {
  final _hbs=ref.watch(bleprovider);
  return  _hbs.heartbeat;
} );

final heartbeats2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(heartbeats);
  return  Heartbeats(hbs);
} );

final saturation=Provider<int>((ref) {
  final _hbs=ref.watch(bleprovider);
  return  _hbs.spo2;
} );

final saturation2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(saturation);
  return  SPO2(hbs);
} );

final temperatureprovider=Provider<double>((ref) {
  final _hbs=ref.watch(bleprovider);
  return  _hbs.temperature;
} );

final temperatureprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(temperatureprovider);
  return  Temperature(hbs);
} );

final respirationprovider=Provider<int>((ref) {
  final _hbs=ref.watch(bleprovider);
  return  _hbs.respiration;
} );

final respirationprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(respirationprovider);
  return  RespirationRate(hbs);
} );

final systolicprovider=Provider<int>((ref) {
  final _hbs=ref.watch(bleprovider);
  return  _hbs.systolic;
} );

final systolicprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(systolicprovider);
  return  Systolic(hbs);
} );

final diastolicprovider=Provider<int>((ref) {
  final _hbs=ref.watch(bleprovider);
  return  _hbs.diastolic;
} );

final diastolicprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(diastolicprovider);
  return  Diastolic(hbs);
} );

final ecgprovider=Provider<List<double>>((ref) {
  final _hbs=ref.watch(bleprovider);
  return _hbs.dataToFilter;
} );

final ecgprovider2=ChangeNotifierProvider.autoDispose((ref) {
  final hbs=ref.watch(ecgprovider);
  return  EcgPro(hbs);
} );

final batterylevelindicator=Provider<double>((ref){
  final _hbs=ref.watch(bleprovider);
  return _hbs.batteryVolt;
});

final batterylevelindicator2=ChangeNotifierProvider.autoDispose((ref){
  final hbs=ref.watch(batterylevelindicator);
  return Battery(hbs);
});

final batterychrgingindicator=Provider<bool>((ref){
  final _hbs=ref.watch(bleprovider);
  return _hbs.charging;
});

final batterychrgingindicator2=ChangeNotifierProvider.autoDispose((ref){
  final hbs=ref.watch(batterychrgingindicator);
  return Battery_charging(hbs);
});

final bmiprovider=Provider<double>((ref){
  final _hbs=ref.watch(bleprovider);
  return _hbs.bmi;
});

final bmiproviders2=ChangeNotifierProvider.autoDispose((ref){
  final hbs=ref.watch(bmiprovider);
  return Bmi(hbs);
});

final blinkprovider=Provider<bool>((ref){
  final _hbs=ref.watch(bleprovider);
  return _hbs.blinkhb;
});

final blinkprovider2=ChangeNotifierProvider.autoDispose((ref){
  final hbs=ref.watch(blinkprovider);
  return Blink(hbs);
});
// final bmiprovider=ChangeNotifierProvider.autoDispose((ref){
//   return Bmi();
// });




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( ProviderScope(child: MyApp()));
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartPage()
    );
  }
}


class StartPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something Went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AuthChecker();
        }
        //loading
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class AuthChecker extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _authState = watch(authStateProvider);
    return _authState.when(
      data: (value) {
        if (value != null) {
          // value.reload();
          // try {
          //   value.reload();
          // } on FirebaseAuthException catch (e) {
          //   if (e.code == 'user-disabled') {
          //     print("Disabled");
          //   }
          // }
          return
            // AnimationPage();
            Connect();
        }
        return AuthScreen();
      },
      loading: () {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (_, __) {
        return Scaffold(
          body: Center(
            child: Text("OOPS"),
          ),
        );
      },
    );
  }
}