import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon/Screens/forgotPasswordScreen.dart';
import 'package:hackathon/Screens/registrationScreen.dart';
import 'package:hackathon/database/database.dart';

import '../database/validators.dart';
import '../widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController _email = new TextEditingController();

  TextEditingController _pass = new TextEditingController();

  bool isEmail = false;
  bool isPass = false;
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
                child:
                    Center(child: SvgPicture.asset("assets/login_vector.svg")),
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
                              hintStyle: TextStyle(color: Color(0xfff0000000)),
                              hintText: "Password"),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => ForgotPasswordScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 5, top: 5),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          isEmail = validateEmail(context, _email.text);
                          isPass = validatePass(context, _pass.text);

                          if (isEmail && isPass) {
                            Login(context, _email.text, _pass.text);
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
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => RegistrationScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have an account ? ",
                              style: TextStyle(
                                  color: Color(0xfffC5C5C5), fontSize: 16),
                            ),
                            Text(
                              "Register first!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
