import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Screens/forgotPasswordScreen.dart';
import 'package:hackathon/Screens/homeScreen.dart';
import 'package:hackathon/Screens/leadListingScreen.dart';
import 'package:hackathon/Screens/loginScreen.dart';
import 'package:hackathon/Screens/otpScreen.dart';

import 'package:hackathon/Screens/qrCodeGenerator.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:hackathon/Screens/qrCodeScanScreen.dart';
import 'package:hackathon/Screens/registrationScreen.dart';
import 'package:hackathon/Screens/setupProfileScreen.dart';
import 'package:hackathon/Screens/splashScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
          textTheme: TextTheme(titleMedium: GoogleFonts.lato())),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? HomeScreen()
          : LoginScreen(),
    ),
  );
}
