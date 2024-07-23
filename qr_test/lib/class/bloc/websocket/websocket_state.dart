part of 'websocket_bloc.dart';

abstract class WebSocketState extends Equatable {
  const WebSocketState();

  @override
  List<Object> get props => [];
}

class WebSocketInitial extends WebSocketState {}

class WebSocketAuthenticating extends WebSocketState{
  final Color color;
  const WebSocketAuthenticating({required this.color});
  
  @override
  List<Object> get props => [color];

}

class WebSocketConnected extends WebSocketState {
  final dynamic data;
  const WebSocketConnected({required this.data});

  @override
  List<Object> get props => [data];

}

class WebSocketDisconnected extends WebSocketState {
  final dynamic error;
  const WebSocketDisconnected({this.error});

  @override
  List<Object> get props => [(error == null) ? '' : error];
}