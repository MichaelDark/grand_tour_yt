import 'package:flutter/material.dart';

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
            backgroundColor: ImageListTile.backgroundColor.withOpacity(0.9),
            child: const Icon(
              Icons.videocam_rounded,
              color: Colors.red,
            ),
          ),
        ),
      ],
      onTap: () {
        Navigator.of(context).pushNamed(
          VideoPage.routeName,
          arguments: VideoPageArguments(
            title: video.title,
            videoId: video.videoId,
          ),
        );
      },
    );
  }
}
