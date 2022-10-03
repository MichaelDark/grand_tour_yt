import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/youtube/youtube_video.dart';
import '../../pages/video_page.dart';
import '../../utils/youtube_thumbnail_ext.dart';
import 'image_list_tile.dart';

class YoutubeVideoListTile extends StatelessWidget {
  final YoutubeVideo video;

  const YoutubeVideoListTile({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return ImageListTile(
      title: video.title,
      image: video.thumbnail.image,
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
        if (video.publishedAt != null)
          Positioned(
            top: 8,
            left: 8,
            child: RawChip(
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: Text(
                timeago.format(
                  video.publishedAt!,
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
            onGenerateTitle: (context) => video.title,
            videoId: video.videoId,
          ),
        );
      },
    );
  }
}
