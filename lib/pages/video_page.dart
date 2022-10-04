import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../di/locator.dart';
import '../l10n/youtube_strings.dart';
import '../models/youtube/youtube_video.dart';
import '../utils/build_context_ext.dart';
import '../view_models/view_model_factory.dart';
import '../widgets/resources/resource_builder.dart';

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
      flags: const YoutubePlayerFlags(
        // autoPlay: true,
        autoPlay: false,
        mute: false,
        showLiveFullscreenButton: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = locator<ViewModelFactory>().video(widget.videoId);
    final mediaQuery = MediaQuery.of(context);
    const aspectRatio = 16 / 9;
    final size = mediaQuery.size;
    final videoWidth = size.width;
    final videoHeight = size.width / aspectRatio;
    final videoSize = Size(videoWidth, videoHeight);

    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressColors: const ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.redAccent,
              ),
            ),
            builder: (context, player) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(widget.title),
                    automaticallyImplyLeading: true,
                    elevation: 8,
                    pinned: true,
                    bottom: PreferredSize(
                      preferredSize: videoSize,
                      child: player,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ResourceBuilder(
                      resource: viewModel.videoResource,
                      builder: (context, video) {
                        return _VideoDetailsView(video: video);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _VideoDetailsView extends StatelessWidget {
  final YoutubeVideo video;

  const _VideoDetailsView({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              video.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    YoutubeStrings.of(context).nViews(video.viewCount),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Text(
                  '•',
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    YoutubeStrings.of(context).videoDate(
                      video.publishedAt,
                      timeago.format(
                        video.publishedAt,
                        locale: Localizations.localeOf(context).toLanguageTag(),
                      ),
                    ),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 8,
              children: [
                _IconedLabel(
                  icon: const Icon(Icons.thumb_up_alt_rounded),
                  label: YoutubeStrings.of(context).numberWithDecimalPattern(
                    video.likeCount,
                  ),
                ),
                _IconedLabel(
                  icon: const Icon(Icons.comment_rounded),
                  label: YoutubeStrings.of(context).numberWithDecimalPattern(
                    video.commentCount,
                  ),
                ),
                if (video.licensedContent) ...[
                  _IconedLabel(
                    icon: const Icon(Icons.verified_rounded),
                    label: YoutubeStrings.of(context).videoLicencedLabel,
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              video.description,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconedLabel extends StatelessWidget {
  final Widget icon;
  final String label;

  const _IconedLabel({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
