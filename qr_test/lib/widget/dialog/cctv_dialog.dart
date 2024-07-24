import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class CCTVDialog extends StatefulWidget {
  final String rtspUrl;
  const CCTVDialog({super.key, required this.rtspUrl});

  @override
  State<StatefulWidget> createState() => _CCTVDialogState();
}

class _CCTVDialogState extends State<CCTVDialog> {
  late final Player player = Player();
  late final VideoController controller = VideoController(player);

  final playlist = Playlist(
    [
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/201"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/301"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/401"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/501"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/601"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/701"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/801"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/901"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/1001"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/1101"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/1201"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/1301"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/1401"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/1501"),
      Media("rtsp://admin:rklg;biNf@192.168.10.50:554/Streaming/channels/1601"),
      
    ]
  );

  @override
  void initState() {
    super.initState();
    // player.open(Media(widget.rtspUrl));
    player.open(playlist);

  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(padding: EdgeInsets.only(top: 30)),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 9.0 / 16.0,
            child: Video(controller: controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: () async => {await player.previous()}, icon: const Icon(Icons.navigate_before, color: Colors.white,)),
              IconButton(onPressed: () async =>{await player.next()}, icon: const Icon(Icons.navigate_next, color: Colors.white,))
            ],
          ),
          TextButton(
            child: const Text('Close', style: TextStyle(color: Colors.white),),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
