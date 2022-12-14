import 'package:flutter/material.dart';

import '../di/locator.dart';
import '../models/youtube/youtube_playlist_item.dart';
import '../utils/build_context_ext.dart';
import '../view_models/view_model_factory.dart';
import '../widgets/slivers/sliver_paged_image_tile_list.dart';
import '../widgets/tiles/youtube_playlist_item_list_tile.dart';

class PlaylistPageArguments {
  final String Function(BuildContext) onGenerateTitle;
  final String playlistId;

  const PlaylistPageArguments({
    required this.onGenerateTitle,
    required this.playlistId,
  });
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
    final args = context.getArgs<PlaylistPageArguments>();
    final viewModel = locator<ViewModelFactory>().playlist(args.playlistId);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.onGenerateTitle(context)),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPagedImageTileList<YoutubePlaylistItem>(
                resource: viewModel.playlistItemsResource,
                builder: (_, item, __) {
                  return YoutubePlaylistItemListTile(playlistItem: item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
