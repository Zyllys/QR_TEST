import "dart:convert";
import 'package:http/http.dart' as http;
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:qr_test/class/login/login_status.dart";

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());
        try {
          //login stuff here
          await Future.delayed(const Duration(seconds: 2));
          LoginStatus loginState = await login(event.username, event.password);
          if (loginState.status == "ok") {
            emit(LoginSuccess());
          } else if (loginState.status == "error") {
            throw loginState.message;
          }
        } catch (error) {
          emit(LoginFailure(error: error.toString()));
        }
      }
    });
  }

  Future<LoginStatus> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://10.88.10.104:3000/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return LoginStatus.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
