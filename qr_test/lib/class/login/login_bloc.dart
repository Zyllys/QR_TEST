import "dart:convert";
import 'package:http/http.dart' as http;
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:qr_test/class/login/login_status.dart";
import "package:shared_preferences/shared_preferences.dart";

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String url = '10.88.10.104:3000';

  //Bloc map Event to State
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        await handleLogin(emit, login(event.username, event.password));
      } else if (event is LoginToken) {
        await handleLogin(emit, checkToken(event.token));
      } else if (event is LogoutEvent) {
        await clearToken();
        emit(LoginInitial());
      }
    });
  }

  //remove token from shared preferences
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  //normal username/password login
  Future<LoginStatus> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://$url/api/login'),
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

  //login with token
  Future<LoginStatus> checkToken(String token) async {
    final response = await http.post(
      Uri.parse('http://$url/api/checkToken'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return LoginStatus.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
  
  //initiating login process, show loading animation and handle the result
  Future<void> handleLogin(Emitter<LoginState> emit, Future<LoginStatus> loginFunction) async {
    emit(LoginLoading());
    try {
      //login stuff here
      await Future.delayed(const Duration(seconds: 1));
      LoginStatus loginState = await loginFunction;
      if (loginState.status == "ok") {
        await SharedPreferences.getInstance()
            .then((pref) => pref.setString('token', loginState.token));
        emit(LoginSuccess());
      } else if (loginState.status == "error") {
        throw loginState.message;
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
