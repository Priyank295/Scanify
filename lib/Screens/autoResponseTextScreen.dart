import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/widgets.dart';

class AutoResponseText extends StatefulWidget {
  const AutoResponseText({super.key});

  @override
  State<AutoResponseText> createState() => _AutoResponseTextState();
}

TextEditingController _msg = new TextEditingController();
String msg = "";
void getValue(BuildContext context) async {
  // _msg.clear();
  DocumentReference docRef = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  try {
    DocumentSnapshot documentSnapshot = await docRef.get();
    if (documentSnapshot.exists) {
      msg = documentSnapshot.get('wp msg');
    }
  } catch (e) {
    var snack = SnackBar(content: Text(e.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

class _AutoResponseTextState extends State<AutoResponseText> {
  @override
  Widget build(BuildContext context) {
    getValue(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Auto Response Text for Whatsapp✌",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
              "Note: Provide your message that will be your auto response message."),
          SizedBox(
            height: 20,
          ),
          Text(
            "Your Auto Response Text is : " + msg,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) async {
              await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({
                "wp msg": value,
              });
              setState(() {});
            },
            controller: _msg,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
                hintText: "Change Your Message"),
          ),
        ],
      ),
    );
  }
}
