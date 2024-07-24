import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_test/class/bloc/fetch/stations_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_test/class/bloc/websocket/websocket_bloc.dart';
import 'package:qr_test/class/bloc/websocket/websocket_manager.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:qr_test/widget/dialog/cctv_dialog.dart';

class StationDataPage extends StatelessWidget {
  //TODO: rename Data class name
  final Data station;
  final WebSocketManager wsManager =
      WebSocketManager(uri: Uri.parse("ws://10.88.10.104:3003"));
  StationDataPage({super.key, required this.station});

  //TODO: pass this in with station?
  final String rtspUrl =
      'rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/201';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () async {
            await wsManager
                .disconnect()
                .then((value) => Navigator.pop(context));
          },
        ),
        title: Text(station.name!),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocProvider<WebSocketBloc>(
            create: (context) => WebSocketBloc(),
            child: BlocBuilder<WebSocketBloc, WebSocketState>(
              builder: ((context, state) {
                //set the parameters here
                wsManager.station = [station.tablename!];
                // wsManager.station = ['T1S39'];

                wsManager.bloc = BlocProvider.of<WebSocketBloc>(context);
                if (state is WebSocketInitial) {
                  //connect websocket
                  return Center(
                    child: TextButton(
                      child: const Text('Connect'),
                      onPressed: () {
                        wsManager.connect();
                      },
                    ),
                  );
                } else if (state is WebSocketAuthenticating) {
                  return CircularProgressIndicator(color: state.color);
                } else if (state is WebSocketDisconnected) {
                  return Text(state.error == null ? '' : state.error!);
                } else if (state is WebSocketConnected) {
                  return Text(jsonEncode(state.data));
                }

                return const Text('');
              }),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (context) => CCTVDialog(rtspUrl: rtspUrl),
              ),
              child: const Text("CCTV"),
            ),
          )
        ],
      ),
    );
  }
}
