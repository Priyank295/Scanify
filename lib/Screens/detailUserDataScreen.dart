import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vcard_maintained/vcard_maintained.dart';
import 'package:path_provider/path_provider.dart';

class DetailUserDataScreen extends StatefulWidget {
  DocumentSnapshot snapshot;
  DetailUserDataScreen(this.snapshot);

  @override
  State<DetailUserDataScreen> createState() => _DetailUserDataScreenState();
}

class _DetailUserDataScreenState extends State<DetailUserDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Name : " +
                      widget.snapshot.get("firstName") +
                      " " +
                      widget.snapshot.get("lastName"),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Email : " + widget.snapshot.get("email"),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Mobile No : " + widget.snapshot.get("mobile No"),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Website : " + widget.snapshot.get("website"),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Address : " + widget.snapshot.get("address"),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  // final vCard = VCard();

                  // Set the contact information
                  // vCard.firstName = widget.snapshot.get("firstName");
                  // vCard.lastName = widget.snapshot.get("lastName");
                  // vCard.email = widget.snapshot.get("email");
                  // vCard.homePhone = widget.snapshot.get("mobile No");

                  // Generate the VCF file
                  // final file = await generateVCFFile(vCard);

                  // Share the VCF file
                  Share.shareFiles([
                    widget.snapshot.get("firstName"),
                    widget.snapshot.get("lastName"),
                    widget.snapshot.get("email"),
                    widget.snapshot.get("mobile No")
                  ], text: 'Check out my contact information!');
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
                    "Share Contact",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  )),
                ),
              ),
            ]),
      ),
    );
  }

//   Future<File> generateVCFFile(VCard vCard) async {
//     // Get the directory for storing temporary files
//     final directory = await getTemporaryDirectory();

//     // Create a new file with a unique filename
//     final file =
//         File('${directory.path}/${DateTime.now().millisecondsSinceEpoch}.vcf');

//     // Write the VCF data to the file
//     await file.writeAsString(vCard.getFormattedString());

//     // Return the file
//     return file;
//   }
// }
}
