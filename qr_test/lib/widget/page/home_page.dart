import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_test/class/login/login_bloc.dart';
import 'package:qr_test/qr_scanner.dart';
import 'package:qr_test/widget/dialog/logout_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LoginBloc loginBloc;
  String barcodeString = '';
  String? token;

  Future<Barcode> getBarcode() async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const QRScanner()));
  }

  Future<void> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  void _awaitReturnQR(BuildContext context) async {
    final Barcode barcode = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const QRScanner()));
    setState(() {
      barcodeString = barcode.rawValue!;
    });
  }

  @override
  void initState() {
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout_rounded),
          color: Colors.black,
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                LogoutDialog(loginBloc: loginBloc),
          ),
        ),
        centerTitle: true,
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Token: $token"),
            Text("QR Value: $barcodeString"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_awaitReturnQR(context)},
        tooltip: 'QR Scanner',
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
