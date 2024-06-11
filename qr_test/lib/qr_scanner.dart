import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<StatefulWidget> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> with WidgetsBindingObserver{

  bool notPopped = true;

  void _handleBarcode(BarcodeCapture barcode) {
    if(mounted && notPopped) {
      Navigator.pop(context,barcode.barcodes.firstOrNull);
      notPopped = false; // prevent popping multiple times, there may be a better method
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("QR Scanner"),),
      body: MobileScanner(onDetect: _handleBarcode),
    );
  }
}