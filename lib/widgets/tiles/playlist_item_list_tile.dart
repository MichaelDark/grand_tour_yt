import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:grandtouryt/utils/thumbnails_extension.dart';

import '../../pages/video_page.dart';
import 'image_list_tile.dart';

class PlaylistItemListTile extends StatelessWidget {
  final PlaylistItem playlistItem;

  const PlaylistItemListTile({super.key, required this.playlistItem});

  @override
  Widget build(BuildContext context) {
    return ImageListTile(
      title: playlistItem.snippet!.title!,
      image: playlistItem.snippet!.thumbnails!.image,
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
            title: playlistItem.snippet!.title!,
            videoId: playlistItem.contentDetails!.videoId!,
          ),
        );
      },
    );
  }
}
