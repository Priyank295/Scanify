import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon/Screens/forgotPasswordScreen.dart';
import 'package:hackathon/Screens/loginScreen.dart';
import 'package:hackathon/Screens/otpScreen.dart';
import 'package:hackathon/database/database.dart';
import 'package:hackathon/widgets.dart';

import '../database/validators.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _phone = new TextEditingController();

  bool isEmail = false;
  bool isPass = false;
  bool isPhone = false;
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
                child: Center(child: Image.asset("assets/register_vector.png")),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 50,
                          child: textField(context, "Email", _email)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 50,
                          child: TextField(
                            obscureText: true,
                            controller: _pass,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xfff66BBE0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xfff66BBE0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xfff66BBE0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                hintStyle:
                                    TextStyle(color: Color(0xfff0000000)),
                                hintText: "Password"),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 50,
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: _phone,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xfff66BBE0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xfff66BBE0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xfff66BBE0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                hintStyle:
                                    TextStyle(color: Color(0xfff0000000)),
                                hintText: "Mobile No"),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          isEmail = validateEmail(context, _email.text);
                          isPass = validatePass(context, _pass.text);

                          if (isEmail && isPass && _phone.text.length == 10) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => OtpScreen(
                                        _phone.text, _email.text, _pass.text)));
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
                            "Register",
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
