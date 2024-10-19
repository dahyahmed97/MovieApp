import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String videoKey;
  const YoutubePlayerWidget({super.key, required this.videoKey});

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _youtubeController;
  @override
  void initState() {

    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId:widget.videoKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: true,
        controlsVisibleAtStart: true,
        hideControls: false,
        showLiveFullscreenButton: false,


      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: YoutubePlayer(
        showVideoProgressIndicator: true,
        controller: _youtubeController,
      ),
    );
  }
}
