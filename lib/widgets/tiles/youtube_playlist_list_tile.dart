import 'package:flutter/material.dart';

import '../../models/youtube/youtube_playlist.dart';
import '../../pages/playlist_page.dart';
import '../../utils/youtube_thumbnail_ext.dart';
import 'image_list_tile.dart';

class YoutubePlaylistListTile extends StatelessWidget {
  final YoutubePlaylist playlist;

  const YoutubePlaylistListTile({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ImageListTile(
      title: playlist.title,
      image: playlist.thumbnail.image,
      additionalWidgets: [
        Positioned(
          top: 8,
          right: 8,
          child: CircleAvatar(
            backgroundColor:
                ImageListTile.getBackgroundColor(context).withOpacity(0.9),
            child: Icon(
              Icons.playlist_play_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
      onTap: () {
        Navigator.of(context).pushNamed(
          PlaylistPage.routeName,
          arguments: PlaylistPageArguments(
            onGenerateTitle: (context) => playlist.title,
            playlistId: playlist.id,
          ),
        );
      },
    );
  }
}
