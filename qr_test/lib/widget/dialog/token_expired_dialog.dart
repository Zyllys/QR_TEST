import 'package:flutter/material.dart';

class TokenExpiredDialog extends StatelessWidget {

  const TokenExpiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('User Token Expired.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => 
            Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ]
    );
  }

}