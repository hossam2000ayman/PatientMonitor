


import 'package:cloud_firestore/cloud_firestore.dart';


class Patient
{
  final FirebaseFirestore _firestore;
  final String _device;
  Patient(this._device,this._firestore);

  Stream<QuerySnapshot> get patientdetails => _firestore.collection("Patients").where('Device',isEqualTo:_device).where("Status",isEqualTo: "Admitted" ).snapshots();

  double _height=0;
  double get height=>_height;

  double _weight=0;
  double get weight=>_weight;

  void add_height(double height)
  {
    _height=height;
  }
  void add_weight(double weight)
  {
    _weight=weight;
  }


  void Discharge(String id)
  {
    print("Hello");
    _firestore.collection("Patients").doc(id).update({
      "Status": "Discharged",
      "Date of Discharge": DateTime.now()
    });
  }

  void update_height(String id,double height)
  {
    print("Height");
    _firestore.collection("Patients").doc(id).update({
      "Height":height,
    });
  }
  void update_weight(String id,double weight)
  {
    print("Weight");
    _firestore.collection("Patients").doc(id).update({
      "Weight":weight,
    });
  }
}