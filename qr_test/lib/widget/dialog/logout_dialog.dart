import 'package:flutter/material.dart';
import 'package:qr_test/class/bloc/login/login_bloc.dart';

class LogoutDialog extends StatelessWidget {
  final LoginBloc loginBloc;

  const LogoutDialog({super.key, required this.loginBloc});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Do you want to logout?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'Yes'),
            loginBloc.add(const LogoutButtonPressed()),},
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'No'), 
          child: const Text('No'),
        ),

      ]
    );
  }

}