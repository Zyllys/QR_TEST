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
  int currentIndex = 0;
  late final Player player = Player();
  late final VideoController controller = VideoController(player);

  final playlist = Playlist([
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
  ]);

  @override
  void initState() {
    super.initState();
    setState(() {
      currentIndex = playlist.index;
    });
    // player.open(Media(widget.rtspUrl));
    player.open(playlist);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  //generate selector list
  List<Widget> generateMenu() {
    List<Widget> list = List.empty(growable: true);
    for (int i = 0; i < playlist.medias.length; i++) {
      String displayText = playlist.medias[i].uri.split('/').last;
      list.add(
        TextButton(
          style: ButtonStyle(
              backgroundColor: (currentIndex == i)
                  ? const MaterialStatePropertyAll<Color>(Colors.orange)
                  : null),
          onPressed: () => {
            player.jump(i),
            setState(
              () {
                currentIndex = i;
              },
            )
          },
          child: Text(
            displayText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF000000),
      shadowColor: const Color(0xFF000000),
      surfaceTintColor: const Color(0xFF000000),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(padding: EdgeInsets.only(top: 30)),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 9.0 / 16.0,
            child: IgnorePointer(child: Video(controller: controller)),
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: generateMenu(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () async => {
                  await player.previous().then((value) {
                    setState(
                      () {
                        if (currentIndex > 0) {
                          currentIndex = currentIndex - 1;
                        }
                      },
                    );
                  }),
                },
                icon: const Icon(
                  Icons.navigate_before,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () async => {
                  await player.next().then((value) {
                    setState(
                      () {
                        if (currentIndex < playlist.medias.length - 1) {
                          currentIndex = currentIndex + 1;
                        }
                      },
                    );
                  })
                },
                icon: const Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          TextButton(
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
