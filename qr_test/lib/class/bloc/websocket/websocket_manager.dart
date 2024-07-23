import 'dart:convert';
import 'package:qr_test/class/bloc/websocket/websocket_bloc.dart';
import 'package:qr_test/class/common/token_mixin.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketManager with Token {
  List<String>? topics;
  final Iterable<String> wsProtocol = {"testnamesocket"};
  final Uri uri;
  WebSocketBloc? wsBloc;
  late WebSocketChannel channel;

  WebSocketManager(
      {required this.uri});

  set station(List<String> topics) {
    this.topics = topics;
  }

  set bloc(WebSocketBloc wsBloc) {
    this.wsBloc = wsBloc;
  }

  void connect() async {

    //check for topics
    if(topics == null) {
      throw const FormatException('Topics not provided');
    }

    //check for bloc
    if(wsBloc == null) {
      throw const FormatException('WebSocketBloc not provided');
    }

    //trigger bloc event and connect ws
    wsBloc!.add(WebSocketConnect());
    channel = WebSocketChannel.connect(uri, protocols: wsProtocol);
    await channel.ready;

    //trigger bloc event and send handshake message
    wsBloc!.add(WebSocketHandshake());
    String token = await getToken().then((value) => value!);
    Map<String, dynamic> payload = {'token': token, 'topics': topics};
    channel.sink.add(jsonEncode(payload));

    //trigger an event when received message
    channel.stream.listen(
      //onData,
      (message) {
        //TODO: REMOVE PRINT WHEN DONE
        print(message);
        Map<String, dynamic> data = jsonDecode(message);
        wsBloc!.add(WebSocketOnMessage(data: data));
      },

      onError: (error) {
        wsBloc!.add(WebSocketDisconnect(error));
      },

      onDone: () {
        wsBloc!.add(const WebSocketDisconnect("WebSocket Disconnected"));
        print("WebSocket Disconnected");
      },
    );
  }

  //close ws, then trigger event
  Future<void> disconnect() async {
    try{
      await channel.sink.close();
    } catch (error) {
      print("Error: $error");
      wsBloc!.add(WebSocketDisconnect(error));
    }
  }
}
