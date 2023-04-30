import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon/Screens/loginScreen.dart';
import 'package:hackathon/Screens/registrationScreen.dart';
import 'package:hackathon/database/database.dart';
import 'package:hackathon/database/validators.dart';
import 'package:hackathon/widgets.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

TextEditingController _email = new TextEditingController();

bool isEmail = false;

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Forgot Password"),
    //   ),
    //   body: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //     child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Text(
    //             "Enter your Email address and we'll send you link to your email that you can change your password",
    //             style: TextStyle(color: Colors.black, fontSize: 18),
    //           ),
    //           SizedBox(
    //             height: 30,
    //           ),
    //           textField(context, "Enter Email address", _email),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           InkWell(
    //             onTap: () {
    //               isEmail = validateEmail(context, _email.text);

    //               if (isEmail) {
    //                 forgotPassword(context, _email.text);
    //               }
    //             },
    //             child: Container(
    //               height: 60,
    //               width: 120,
    //               decoration: BoxDecoration(
    //                 color: Colors.blueAccent,
    //                 borderRadius: BorderRadius.circular(12),
    //               ),
    //               child: Center(
    //                   child: Text(
    //                 "Send Email",
    //                 style: TextStyle(color: Colors.white),
    //               )),
    //             ),
    //           ),
    //         ]),
    //   ),
    // );
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
                child: Center(child: SvgPicture.asset("assets/bored.svg")),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                            "Enter your Email address and we'll send you link to your email that you can change your password"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      textField(context, "Email", _email),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          isEmail = validateEmail(context, _email.text);

                          if (isEmail) {
                            forgotPassword(context, _email.text);
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
                            "Send Link",
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
