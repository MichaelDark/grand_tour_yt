import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../di/locator.dart';
import '../models/youtube/youtube_video.dart';
import '../utils/build_context_ext.dart';
import '../view_models/playlist_view_model.dart';
import '../widgets/tiles/youtube_video_list_tile.dart';

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
    final viewModel = locator<PlaylistViewModelFactory>().get(args.playlistId);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(args.onGenerateTitle(context)),
          automaticallyImplyLeading: true,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: PagedSliverList(
                  pagingController: viewModel.playlistItemsResource.controller,
                  builderDelegate: PagedChildBuilderDelegate<YoutubeVideo>(
                    itemBuilder: (_, item, __) {
                      return YoutubeVideoListTile(video: item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
