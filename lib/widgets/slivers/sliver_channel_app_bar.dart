import 'package:flutter/material.dart';

import '../../models/youtube/youtube_channel.dart';
import '../../utils/build_context_ext.dart';
import '../../utils/youtube_thumbnail_ext.dart';
import '../inner_shadow_container.dart';
import '../youtube_search_delegate.dart';

class SliverChannelAppBar extends SliverAppBar {
  static const aspectRatio = 16 / 9;

  static double calculateAppBarHeight(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = width / aspectRatio;
    return height;
  }

  SliverChannelAppBar({
    super.key,
    required YoutubeChannel channel,
    required super.expandedHeight,
  }) : super(
          floating: false,
          pinned: true,
          actions: [
            _ChannelSearchButton(channelId: channel.id),
          ],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: const EdgeInsets.all(4.0)
                .add(const EdgeInsets.only(bottom: 4.0))
                .add(const EdgeInsets.symmetric(horizontal: 24.0)),
            title: _ChannelSpaceBarTitle(
              channel: channel,
            ),
            background: _ChannelSpaceBarBackground(
              channel: channel,
              aspectRatio: aspectRatio,
            ),
          ),
        );
}

class _ChannelSearchButton extends StatelessWidget {
  final String channelId;

  const _ChannelSearchButton({
    Key? key,
    required this.channelId,
  }) : super(key: key);

  void _navigateToSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: YoutubeSearchDelegate(channelId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _navigateToSearch(context),
      icon: const Icon(Icons.search_rounded),
    );
  }
}

class _ChannelSpaceBarTitle extends StatelessWidget {
  final YoutubeChannel channel;

  const _ChannelSpaceBarTitle({
    Key? key,
    required this.channel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: context.resolveAppBarColor(),
      ),
      child: Material(
        elevation: 8,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        child: Text(
          channel.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
    );
  }
}

class _ChannelSpaceBarBackground extends StatelessWidget {
  final YoutubeChannel channel;
  final double aspectRatio;

  const _ChannelSpaceBarBackground({
    Key? key,
    required this.channel,
    required this.aspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: aspectRatio,
          child: Image(
            image: channel.thumbnail.image,
            fit: BoxFit.cover,
          ),
        ),
        AspectRatio(
          aspectRatio: aspectRatio,
          child: const ImageInnerShadow(),
        ),
      ],
    );
  }
}
