import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:qr_test/class/bloc/login/login_bloc.dart';
import 'package:qr_test/class/bloc/login/login_status.dart';
import 'package:qr_test/widget/dialog/token_expired_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? token;
  late LoginStatus loginStatus;

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  @override
  void initState(){
    super.initState();
    _getToken();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    if(token != null) {
      loginBloc.add(LoginToken(token: token!));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            if (state.error == "Token error!.") {
              showDialog(context: context, builder: ((context) => const TokenExpiredDialog()));
            } else {
              showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Login Failed'),
                content: Text(state.error),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            }
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Username';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter your password'),
                        validator: (value) {
                          const int minPwLength = 4;
                          if (value == null ||
                              value.length < minPwLength ||
                              value.isEmpty) {
                            return 'Your Password must be longer than $minPwLength character';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        onPressed: state is! LoginLoading
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  loginBloc.add(LoginButtonPressed(
                                      username: _usernameController.text, password: _passwordController.text));
                                }
                              }
                            : null,
                        child: const Text("Login"),
                      ),
                    ),
                    if (state is LoginLoading)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
