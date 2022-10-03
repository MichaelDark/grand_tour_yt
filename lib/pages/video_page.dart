import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/build_context_ext.dart';

class VideoPageArguments {
  final String Function(BuildContext) onGenerateTitle;
  final String videoId;

  const VideoPageArguments({
    required this.onGenerateTitle,
    required this.videoId,
  });
}

class VideoPage extends StatelessWidget {
  static const routeName = '/video';

  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = context.getArgs<VideoPageArguments>();

    return _VideoPage(
      key: UniqueKey(),
      title: args.onGenerateTitle(context),
      videoId: args.videoId,
    );
  }
}

class _VideoPage extends StatefulWidget {
  final String title;
  final String videoId;

  const _VideoPage({
    super.key,
    required this.title,
    required this.videoId,
  });

  @override
  State<_VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<_VideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: YoutubePlayer(
                  controller: _controller,
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
