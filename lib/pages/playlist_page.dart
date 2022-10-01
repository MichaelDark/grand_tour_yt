import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../di/locator.dart';
import '../providers/youtube_channel_view_model.dart';
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
    final viewModel = viewModelFactory.createPaginated(args.playlistId);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.title),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              PagedSliverList(
                pagingController: viewModel.playlistItemsResource.controller,
                builderDelegate: PagedChildBuilderDelegate<PlaylistItem>(
                  itemBuilder: (_, item, __) {
                    return PlaylistItemListTile(playlistItem: item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
