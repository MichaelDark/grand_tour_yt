import 'package:flutter/material.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart'
    as inset_shadow;

import '../l10n/youtube_strings.dart';
import '../models/youtube/youtube_channel.dart';
import '../utils/int_ext.dart';
import '../utils/youtube_thumbnail_ext.dart';

class ChannelInfo extends StatelessWidget {
  final YoutubeChannel channel;

  ChannelInfo({
    required this.channel,
  }) : super(key: ValueKey(channel));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            const aspectRatio = 16 / 9;
            final imageWidth = constraints.maxWidth;
            final imageHeight = constraints.maxWidth / aspectRatio;

            return Stack(
              children: [
                AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Image(
                    image: channel.thumbnail.image,
                    fit: BoxFit.cover,
                  ),
                ),
                const AspectRatio(
                  aspectRatio: aspectRatio,
                  child: ImageInnerShadow(),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: imageHeight - 24),
                    child: ChannelName(
                      constraints: BoxConstraints(maxWidth: imageWidth * 0.75),
                      title: channel.title,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ShadowedAppBar(actions: _buildChips(context)),
                ),
              ],
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            channel.description,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildChips(BuildContext context) {
    return [
      if (channel.subscriberCount != null) ...[
        YoutubeStrings.of(context).nSubscribers(
          channel.subscriberCount!,
          channel.subscriberCount!.formatCount(),
        ),
      ],
      if (channel.videoCount != null) ...[
        YoutubeStrings.of(context).nVideos(channel.videoCount!),
      ],
    ]
        .map(
          (label) => RawChip(
            elevation: 8,
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        )
        .toList();
  }
}

class ImageInnerShadow extends StatelessWidget {
  const ImageInnerShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const inset_shadow.BoxDecoration(
        boxShadow: [
          inset_shadow.BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 64,
            spreadRadius: 16,
            color: Colors.black,
            inset: true,
          ),
        ],
      ),
    );
  }
}

class ChannelName extends StatelessWidget {
  final BoxConstraints constraints;
  final String title;

  const ChannelName({
    super.key,
    required this.constraints,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        constraints: constraints,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}

class ShadowedAppBar extends StatelessWidget {
  final List<Widget> actions;

  const ShadowedAppBar({
    Key? key,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parentRoute = ModalRoute.of(context);
    final canPop = parentRoute?.canPop ?? false;
    final impliesAppBarDismissal = parentRoute?.impliesAppBarDismissal ?? false;

    Widget leading = const SizedBox.shrink();
    if (canPop || impliesAppBarDismissal) {
      leading = const BackButton();
    }

    return Container(
      color: Theme.of(context).colorScheme.shadow.withOpacity(0.25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: -8,
              children: actions,
            ),
          ),
        ],
      ),
    );
  }
}
