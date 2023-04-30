import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/Screens/autoResponseTextScreen.dart';
import 'package:hackathon/Screens/loginScreen.dart';
import 'package:hackathon/Screens/qrCodeGenerator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (ctx) => LoginScreen()),
                        (route) => false));
              },
              child: Row(
                children: [Icon(Icons.logout), Text("Logout")],
              ),
            )
          ],
          title: Text("Profile"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Business"),
              Tab(
                text: "Auto Response Text",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Profile(context),
            AutoResponseText(),
          ],
        ),
      ),
    ); // TabBa,),))
  }
}

Widget Profile(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name : " +
                    snapshot.data!['firstName'] +
                    " " +
                    snapshot.data!['lastName'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email : " + snapshot.data!['email'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Phone : " + snapshot.data!['mobile No'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Website : " + snapshot.data!['website'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Address : " + snapshot.data!['address'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => QrCodeGenerator()));
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
                    "Generate QR Code",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )),
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ),
  );
}
