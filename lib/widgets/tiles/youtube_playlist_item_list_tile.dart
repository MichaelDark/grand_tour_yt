import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/youtube/youtube_playlist_item.dart';
import '../../pages/video_page.dart';
import '../../utils/youtube_thumbnail_ext.dart';
import 'image_list_tile.dart';

class YoutubePlaylistItemListTile extends StatelessWidget {
  final YoutubePlaylistItem playlistItem;

  const YoutubePlaylistItemListTile({super.key, required this.playlistItem});

  @override
  Widget build(BuildContext context) {
    return ImageListTile(
      title: playlistItem.title,
      image: playlistItem.thumbnail.image,
      additionalWidgets: [
        Positioned(
          top: 8,
          right: 8,
          child: CircleAvatar(
            backgroundColor:
                ImageListTile.getBackgroundColor(context).withOpacity(0.9),
            child: Icon(
              Icons.videocam_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        if (playlistItem.publishedAt != null)
          Positioned(
            top: 8,
            left: 8,
            child: RawChip(
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: Text(
                timeago.format(
                  playlistItem.publishedAt!,
                  locale: Localizations.localeOf(context).toLanguageTag(),
                ),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          )
      ],
      onTap: () {
        Navigator.of(context).pushNamed(
          VideoPage.routeName,
          arguments: VideoPageArguments(
            onGenerateTitle: (context) => playlistItem.title,
            videoId: playlistItem.videoId,
          ),
        );
      },
    );
  }
}
