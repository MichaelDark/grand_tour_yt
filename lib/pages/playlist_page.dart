import 'package:flutter/material.dart';

import '../di/locator.dart';
import '../providers/youtube_channel_view_model.dart';
import '../widgets/resource_builder.dart';
import '../widgets/tiles/playlist_item_list_tile.dart';

class PlaylistPageArguments {
  final String title;
  final String playlistId;

  PlaylistPageArguments({required this.title, required this.playlistId});
}

class PlaylistPage extends StatefulWidget {
  static const routeName = '/playlist';

  const PlaylistPage({Key? key}) : super(key: key);

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    final modaRoute = ModalRoute.of(context)!;
    final args = modaRoute.settings.arguments as PlaylistPageArguments;
    final viewModelFactory = locator<YoutubePlaylistViewModelFactory>();
    final viewModel = viewModelFactory.create(args.playlistId);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.title),
          automaticallyImplyLeading: true,
        ),
        body: ResourceBuilder(
          resource: viewModel.playlistItemsResource,
          builder: (context, playlistItems) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final playlistItem = playlistItems[index];

                        return PlaylistItemListTile(
                          playlistItem: playlistItem,
                        );
                      },
                      childCount: playlistItems.length,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
