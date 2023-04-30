import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon/Screens/qrCodeGenerator.dart';
import 'package:hackathon/Screens/setupProfileScreen.dart';
import 'package:hackathon/database/database.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  String Phone, email, password;

  OtpScreen(this.Phone, this.email, this.password);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

String _verificationCode = "";
TextEditingController _otp = new TextEditingController();
OtpFieldController? _otp2 = new OtpFieldController();

class _OtpScreenState extends State<OtpScreen> {
  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${widget.Phone}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (ctx) => QrCodeGenerator()));
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          setState(() {
            _verificationCode = verificationId;
            print("Verification code : " + _verificationCode);
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 30));
  }

  @override
  void initState() {
    // TODO: implement initState
    _verifyPhone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffD7E8F0),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height / 2,
                child: Center(child: SvgPicture.asset("assets/rocket.svg")),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "OTP Verification",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Enter the OTP sent to +91${widget.Phone}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      OTPTextField(
                        controller: _otp2,
                        length: 6,
                        width: MediaQuery.of(context).size.width,
                        // fieldWidth: 80,
                        style: TextStyle(fontSize: 17),
                        // textFieldAlignment: MainAxisAlignment.spaceBetween,
                        fieldStyle: FieldStyle.underline,
                        otpFieldStyle:
                            OtpFieldStyle(borderColor: Color(0xfff2ABFFF)),
                        onChanged: (value) => {
                          print(value),
                        },
                        onCompleted: (pin) async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: _verificationCode,
                                        smsCode: pin))
                                .then((value) {})
                                .then((value) {})
                                .then((value) async {
                                  PhoneAuthCredential phoneAuthCredential =
                                      PhoneAuthProvider.credential(
                                    verificationId: _verificationCode,
                                    smsCode: pin,
                                  );

                                  // Create an EmailAuthCredential object
                                  AuthCredential emailAuthCredential =
                                      EmailAuthProvider.credential(
                                    email: widget.email,
                                    password: widget.password,
                                  );

                                  // Link the two accounts
                                  try {
                                    await FirebaseAuth.instance.currentUser
                                        ?.linkWithCredential(
                                            phoneAuthCredential);
                                    await FirebaseAuth.instance.currentUser
                                        ?.linkWithCredential(
                                            emailAuthCredential);
                                    // Handle successful account linking
                                  } on FirebaseAuthException catch (e) {
                                    // Handle account linking errors
                                    var snack =
                                        SnackBar(content: Text(e.toString()));

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snack);
                                  }
                                })
                                .then((value) => SignUp(context, widget.email,
                                    widget.password, widget.Phone))
                                .then((value) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) =>
                                              SetupProfileScreen()));
                                });
                          } catch (e) {
                            var snack = await SnackBar(
                              content: Text(e.toString()),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          _verifyPhone();
                        },
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                              color: Color(0xfff2ABFFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: _verificationCode,
                                        smsCode: _otp2.toString()))
                                .then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => QrCodeGenerator())));
                          } catch (e) {
                            var snack = await SnackBar(
                              content: Text(e.toString()),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xfff2ABFFF),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                              child: Text(
                            "Verify",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
