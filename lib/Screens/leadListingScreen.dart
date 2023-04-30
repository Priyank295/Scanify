import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon/Screens/detailUserDataScreen.dart';
import 'package:hackathon/database/database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class leadListingScreen extends StatefulWidget {
  const leadListingScreen({super.key});

  @override
  State<leadListingScreen> createState() => _leadListingScreenState();
}

String phoneNumber =
    "+919724793610"; // Replace with the phone number you want to send a message to
String message = "Hello, world!";
String url = "whatsapp://send?phone=${phoneNumber}" +
    "&text=${Uri.encodeComponent(message)}";
Uri uri = Uri.parse(url);

TextEditingController _search = new TextEditingController();

class _leadListingScreenState extends State<leadListingScreen> {
  Stream querySnapshot = FirebaseFirestore.instance
      .collection("Scanned Data")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("Scanned")
      .snapshots();

  void searchUserByName(String search) async {
    final data = FirebaseFirestore.instance
        .collection("Scanned Data")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Scanned")
        .where('firstName', isEqualTo: search)
        .snapshots();
    querySnapshot = data;
  }

  String msg = "";
  void getValue(BuildContext context) async {
    // _msg.clear();
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid);

    try {
      DocumentSnapshot documentSnapshot = await docRef.get();
      if (documentSnapshot.exists) {
        setState(() {
          msg = documentSnapshot.get('wp msg');
        });
      }
    } catch (e) {
      var snack = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
  }

  // Replace with the message you want to send

  @override
  Widget build(BuildContext context) {
    getValue(context);
    return Scaffold(
      backgroundColor: Color(0xfffEBF9FF),
      appBar: AppBar(
        backgroundColor: Color(0xfff3FBDF1),
        title: Text("Lead-Listing"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Center(
                  child: SvgPicture.asset(
                "assets/leading_vector.svg",
              )),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // child: Row(children: [

                          //   Icon(
                          //     Icons.search,
                          //     color: Colors.black,
                          //     size: 30,
                          //   ),
                          //   SizedBox(
                          //     width: 10,
                          //   ),
                          //   Text(
                          //     "Search",
                          //     style: TextStyle(fontSize: 18),
                          //   )
                          // ]),
                          child: TextField(
                            cursorColor: Colors.black,
                            controller: _search,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: "Search",
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.only(top: 20)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            searchUserByName(_search.text);
                            setState(() {});
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xfff3FBDF1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                "Search",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: querySnapshot,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      //   DocumentSnapshot document = snapshot.data!.docs[i];
                      //   if(document.id !=null){
                      //     return ListView.builder(itemBuilder: itemBuilder)
                      //   }
                      // }
                      if (snapshot.data!.docs.length == 0) {
                        return Center(
                          child: Text("No data found!!!"),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot documnet =
                                  snapshot.data!.docs[index];
                              return InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (ctx) =>
                                  //             DetailUserDataScreen(documnet)));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    // border: Border.all(color: Colors.black, width: 2),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name : " +
                                                documnet.get('firstName') +
                                                " " +
                                                documnet.get('lastName'),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "email : " + documnet.get('email'),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Mobile No : " +
                                                documnet.get('mobile no'),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await launch(
                                              "whatsapp://send?phone=91${documnet.get('mobile no')}" +
                                                  "&text=${Uri.encodeComponent(msg.toString())}");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 50,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Color(0xfff3FBDF1),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/whatsapp.svg",
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Send",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
