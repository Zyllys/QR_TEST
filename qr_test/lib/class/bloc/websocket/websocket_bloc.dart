import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qr_test/class/common/token_mixin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'websocket_event.dart';
part 'websocket_state.dart';

class WebSocketBloc extends Bloc<WebSocketEvent, WebSocketState> with Token {

  late WebSocketChannel channel;
  late String token;
  late List<String> topics;
  late String url;
  final Iterable<String> wsProtocol = {"testnamesocket"};

  WebSocketBloc() : super(WebSocketInitial()) {
    on<WebSocketConnect>((event, emit) {
      emit(WebSocketAuthenticating(color: Colors.blue[200]!));
    });

    on<WebSocketHandshake>((event,emit) {
      emit(WebSocketAuthenticating(color: Colors.orange[200]!));
    });

    on<WebSocketOnMessage>((event, emit) {
      emit(WebSocketConnected(data: event.data));
    });

    on<WebSocketDisconnect>((event, emit) {
      emit(WebSocketDisconnected(error: event.error));
    });
  }
}