part of 'websocket_bloc.dart';

abstract class WebSocketEvent extends Equatable {
  const WebSocketEvent();

  @override
  List<Object> get props => [];
}

class WebSocketConnect extends WebSocketEvent {}

class WebSocketHandshake extends WebSocketEvent {}

class WebSocketOnMessage extends WebSocketEvent {
  final Map<String,dynamic> data;

  const WebSocketOnMessage({required this.data});
}

class WebSocketDisconnect extends WebSocketEvent {
  final dynamic error;
  const WebSocketDisconnect([this.error]);
}