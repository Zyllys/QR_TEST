import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_test/class/bloc/login/login_bloc.dart';
import 'package:qr_test/widget/page/home_page.dart';
import 'package:qr_test/widget/page/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
	return MaterialApp(
	  title: 'QR Flutter Demo',
	  theme: ThemeData(
		colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
		useMaterial3: true,
	  ),
	  home: BlocProvider<LoginBloc>(create: (context) => LoginBloc(),
        child: BlocBuilder<LoginBloc,LoginState>(
          builder: (BuildContext context, LoginState state) {
            if (state is LoginSuccess) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          },

        )),
	);
  }
}
