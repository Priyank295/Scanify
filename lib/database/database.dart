import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon/Screens/homeScreen.dart';
import 'package:hackathon/Screens/otpScreen.dart';
import 'package:hackathon/Screens/qrCodeScanScreen.dart';
import 'package:hackathon/Screens/setupProfileScreen.dart';

import '../Screens/loginScreen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _fire = FirebaseFirestore.instance;

Future SignUp(
    BuildContext context, String email, String password, String phone) async {
  try {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _fire.collection("Users").doc(value.user!.uid).set({
        'uid': value.user!.uid,
        'email': email,
        'mobile No': phone,
        'password': password,
      });
    });
  } catch (e) {
    // print(e.toString());
    var snack = await SnackBar(
      content: Text(e.toString()),
    );

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

Future Login(BuildContext context, String email, String password) async {
  try {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        ),
      );
    });
  } catch (e) {
    // print(e.toString());
    var snack = await SnackBar(
      content: Text(e.toString()),
    );

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

Future storeProfileData(BuildContext context, String fname, String lname,
    String web, String add) async {
  try {
    _fire.collection("Users").doc(_auth.currentUser!.uid).update({
      "firstName": fname,
      "lastName": lname,
      "website": web,
      "address": add,
    }).then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => HomeScreen())));
  } catch (e) {
    var snack = await SnackBar(
      content: Text(e.toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

Future forgotPassword(BuildContext context, String email) async {
  try {
    _auth.sendPasswordResetEmail(email: email).then((value) {
      var snack = SnackBar(content: Text("Please check your mail box"));

      ScaffoldMessenger.of(context).showSnackBar(snack);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => LoginScreen(),
          ));
    });
  } catch (e) {
    var snack = SnackBar(content: Text(e.toString()));

    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

Future storeScannedData(String curUid, String uid, String fname, String lname,
    String email, String phone, String web, String add) async {
  _fire
      .collection("Scanned Data")
      .doc(curUid)
      .collection("Scanned")
      .doc(uid)
      .set({
    'firstName': fname,
    'lastName': lname,
    'email': email,
    "uid": uid,
    "mobile no": phone,
    "website": web,
    "address": add,
    "wp msg": "",
  });
}
