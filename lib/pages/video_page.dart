import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPageArguments {
  final String title;
  final String videoId;

  VideoPageArguments({required this.title, required this.videoId});
}

class VideoPage extends StatefulWidget {
  static const routeName = '/video';

  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  YoutubePlayerController? _controller;

  @override
  Widget build(BuildContext context) {
    final modaRoute = ModalRoute.of(context)!;
    final args = modaRoute.settings.arguments as VideoPageArguments;

    _controller ??= YoutubePlayerController(
      initialVideoId: args.videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.title),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.red,
                    handleColor: Colors.redAccent,
                  ),
                  // onReady: () => _controller!.addListener(listener),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
