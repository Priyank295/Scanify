import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/database/database.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:contacts_service/contacts_service.dart';

class ResultOfQrCodeScreen extends StatefulWidget {
  Barcode result;
  ResultOfQrCodeScreen(this.result);

  @override
  State<ResultOfQrCodeScreen> createState() => _ResultOfQrCodeScreenState();
}

class _ResultOfQrCodeScreenState extends State<ResultOfQrCodeScreen> {
  // DocumentReference snapshot = FirebaseFirestore.instance
  @override
  Widget build(BuildContext context) {
    addPerson(given, number) async {
      try {
        PermissionStatus permission = await Permission.contacts.status;

        if (permission != PermissionStatus.granted) {
          await Permission.contacts.request();
          PermissionStatus permission = await Permission.contacts.status;

          if (permission == PermissionStatus.granted) {
            var newPerson = Contact();
            newPerson.givenName = given;
            newPerson.phones = [Item(label: "mobile", value: number)];

            await ContactsService.addContact(newPerson);
          } else {
            // _handleInvalidPermissions(context);
          }
        }
      } catch (e) {
        var snack = await SnackBar(
          content: Text(e.toString()),
        );

        ScaffoldMessenger.of(context).showSnackBar(snack);
      }
    }

    return Scaffold(
      backgroundColor: Color(0xfffEBF9FF),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            height: 150,
            width: double.infinity,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Result",
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc(widget.result.code)
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      addPerson(
                          snapshot.data!['firstName'] +
                              snapshot.data!['lastName'],
                          snapshot.data!['mobile No']);
                      storeScannedData(
                          FirebaseAuth.instance.currentUser!.uid,
                          snapshot.data!['uid'],
                          snapshot.data!['firstName'],
                          snapshot.data!['lastName'],
                          snapshot.data!['email'],
                          snapshot.data!['mobile No'],
                          snapshot.data!['website'],
                          snapshot.data!['address']);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Name : " +
                                snapshot.data!['firstName'] +
                                " " +
                                snapshot.data!['lastName'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Email : " + snapshot.data!['email'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Phone : " + snapshot.data!['mobile No'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Website : " + snapshot.data!['website'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Address : " + snapshot.data!['address'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  })),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
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
    );
  }
}
