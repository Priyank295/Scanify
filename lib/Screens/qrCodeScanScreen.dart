import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:hackathon/Screens/resultQrCodeScreen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScanScreen extends StatefulWidget {
  const QrCodeScanScreen({super.key});

  @override
  State<QrCodeScanScreen> createState() => _QrCodeScanScreenState();
}

Barcode? result;
final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
QRViewController? controller;

class _QrCodeScanScreenState extends State<QrCodeScanScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.blueAccent,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 250,
        ),
      ),
    ));
  }

  void _onQRViewCreated(QRViewController co) {
    controller = co;
    controller!.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => ResultOfQrCodeScreen(result!)));
    });
  }
}
