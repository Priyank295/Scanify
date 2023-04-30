import 'package:flutter/material.dart';
import 'package:hackathon/Screens/homeScreen.dart';
import 'package:hackathon/database/database.dart';
import 'package:hackathon/widgets.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

TextEditingController _fname = new TextEditingController();

TextEditingController _lname = new TextEditingController();

TextEditingController _email = new TextEditingController();

TextEditingController _phone = new TextEditingController();

TextEditingController _web = new TextEditingController();

TextEditingController _address = new TextEditingController();

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffEBF9FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 150,
              width: double.infinity,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              height: MediaQuery.of(context).size.height - 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textField(context, "First Name", _fname),
                    SizedBox(
                      height: 30,
                    ),
                    textField(context, "Last Name", _lname),
                    SizedBox(
                      height: 30,
                    ),
                    textField(context, "Website", _web),
                    SizedBox(
                      height: 30,
                    ),
                    textField(context, "Address", _address),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        if (_fname.text.isEmpty ||
                            _lname.text.isEmpty ||
                            _web.text.isEmpty ||
                            _address.text.isEmpty) {
                          var snack = SnackBar(
                              content:
                                  Text("These Fields should not be empty..."));

                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        } else {
                          storeProfileData(context, _fname.text, _lname.text,
                              _web.text, _address.text);
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
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
