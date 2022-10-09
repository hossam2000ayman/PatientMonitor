import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:patient_monitor_nullsafety/widget/authform.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var isLoading = false;

  void _submitAuthForm(String email, String password, String username,
      bool isLoging, BuildContext ctx) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    UserCredential authResult;
    try {
      if (isLoging) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        setState(() {
          isLoading = false;
        });
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection("User")
            .doc(authResult.user!.uid)
            .set({'email': email, 'username': username});
        setState(() {
          isLoading = false;
        });
      }
    } on PlatformException catch (err) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      var message = "An error occured plaese check your credential";
      if (err.message != null) {
        message = err.message!;
      }
      Scaffold.of(ctx).showBottomSheet(
        (context) => SnackBar(
          content: Text(message),
          backgroundColor: Colors.deepOrange,
        ),
      );
      print(message);
    } catch (err) {
      print(err.toString());
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AuthForm(
        submitFn: _submitAuthForm,
        isLogin: isLoading,
      ),
    );
  }
}
