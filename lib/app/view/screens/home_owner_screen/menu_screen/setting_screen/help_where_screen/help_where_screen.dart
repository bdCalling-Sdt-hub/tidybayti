import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HelpWhereScreen extends StatefulWidget {
  const HelpWhereScreen({super.key});

  @override
  State<HelpWhereScreen> createState() => _HelpWhereScreenState();
}

class _HelpWhereScreenState extends State<HelpWhereScreen> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=a5CKwx01dOE") ?? "";

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    )..addListener(() {
      if (mounted) {
        setState(() {
          _isPlayerReady = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help Video")),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            onReady: () {
              if (!_isPlayerReady) {
                setState(() {
                  _isPlayerReady = true;
                });
              }
            },
            onEnded: (metaData) {
              print("Video Ended: ${metaData.videoId}");
            },
          ),
        ],
      ),
    );
  }
}
