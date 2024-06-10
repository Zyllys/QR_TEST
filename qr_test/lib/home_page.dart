import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_test/qr_scanner.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key, required this.username, required this.password});

  final String username;
  final String password;
  
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Barcode? barcode;
  String barcodeString = '';

  Future<Barcode> getBarcode() async {
    return await Navigator.push(context,MaterialPageRoute(builder: (context) => const QRScanner()));
  }

  void _awaitReturnQR(BuildContext context) async {
    final Barcode barcode = await Navigator.push(context,MaterialPageRoute(builder: (context) => const QRScanner()));
    setState(() {
      barcodeString = barcode.rawValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Home"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("username: ${widget.username}"),
            Text("password: ${widget.password}"),
            Text("QR Value: $barcodeString"),            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _awaitReturnQR(context)
        },
        tooltip: 'QR Scanner',
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
