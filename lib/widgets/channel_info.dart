import 'package:flutter/material.dart';

import '../models/youtube/youtube_channel.dart';
import '../utils/int_ext.dart';

class ChannelInfo extends StatelessWidget {
  final YoutubeChannel channel;

  const ChannelInfo({
    super.key,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    final chips = [
      if (channel.subscriberCount != null)
        RawChip(
          label: Text(
            '${channel.subscriberCount!.formatCount()} subscribers',
          ),
        ),
      if (channel.videoCount != null)
        RawChip(
          label: Text(
            '${channel.videoCount} videos',
          ),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              channel.title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            channel.description,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        if (chips.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: -8,
              children: chips,
            ),
          ),
      ],
    );
  }
}
