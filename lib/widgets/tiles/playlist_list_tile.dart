import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';

import '../../pages/playlist_page.dart';
import 'image_list_tile.dart';

class PlaylistListTile extends StatelessWidget {
  final Playlist playlist;

  const PlaylistListTile({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ImageListTile(
      title: playlist.snippet!.title!,
      imageUrl: playlist.snippet!.thumbnails!.high!.url!,
      additionalWidgets: [
        Positioned(
          top: 8,
          right: 8,
          child: CircleAvatar(
            backgroundColor: ImageListTile.backgroundColor.withOpacity(0.9),
            child: const Icon(
              Icons.playlist_play_rounded,
              color: Colors.red,
            ),
          ),
        ),
      ],
      onTap: () {
        Navigator.of(context).pushNamed(
          PlaylistPage.routeName,
          arguments: PlaylistPageArguments(
            title: playlist.snippet!.title!,
            playlistId: playlist.id!,
          ),
        );
      },
    );
  }
}
