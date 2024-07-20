part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable{
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() => 'LoginButtonPressed { username:$username, password:$password}';

}

class LoginToken extends LoginEvent {
  final String token;

  const LoginToken({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoginToken { token:$token}';
  
}

abstract class LogoutEvent extends LoginEvent {
  const LogoutEvent();
}

class LogoutButtonPressed extends LogoutEvent {
  const LogoutButtonPressed();
}

class LogoutTokenExpired extends LogoutEvent {
  const LogoutTokenExpired();
}