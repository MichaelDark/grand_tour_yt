import 'package:flutter/material.dart';

import '../../l10n/youtube_strings.dart';
import '../../models/youtube/youtube_channel.dart';
import '../../pages/channel_page.dart';
import '../../utils/int_ext.dart';
import '../../utils/youtube_thumbnail_ext.dart';
import 'image_list_tile.dart';

class YoutubeChannelListTile extends StatelessWidget {
  final YoutubeChannel channel;

  const YoutubeChannelListTile({super.key, required this.channel});

  @override
  Widget build(BuildContext context) {
    return ImageListTile(
      title: channel.title,
      image: channel.thumbnail.image,
      additionalWidgets: [
        if (channel.subscriberCount != null)
          Positioned(
            top: 8,
            left: 8,
            child: RawChip(
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: Text(
                YoutubeStrings.of(context).nSubscribers(
                  channel.subscriberCount!,
                  channel.subscriberCount!.formatCount(),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
      ],
      onTap: () {
        Navigator.of(context).pushNamed(
          ChannelPage.routeName,
          arguments: ChannelPageArguments(
            channelId: channel.id,
          ),
        );
      },
    );
  }
}
