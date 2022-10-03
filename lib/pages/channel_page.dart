import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../di/locator.dart';
import '../l10n/youtube_strings.dart';
import '../models/resources/paginated_ui_resource.dart';
import '../models/youtube/youtube_channel.dart';
import '../models/youtube/youtube_playlist.dart';
import '../utils/build_context_ext.dart';
import '../view_models/channel_view_model.dart';
import '../widgets/channel_info.dart';
import '../widgets/resources/resource_builder.dart';
import '../widgets/tiles/youtube_playlist_list_tile.dart';
import 'playlist_page.dart';

class ChannelPageArguments {
  final String channelId;

  const ChannelPageArguments({required this.channelId});
}

class ChannelPage extends StatelessWidget {
  static const routeName = '/channel';

  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = context.getArgs<ChannelPageArguments>();
    final viewModel = locator<ChannelViewModelFactory>().get(args.channelId);

    return SafeArea(
      child: Scaffold(
        body: ResourceBuilder(
          resource: viewModel.channelResource,
          builder: (context, channel) {
            return ChannelView(
              channel: channel,
              playlistsResource: viewModel.playlistsResource,
            );
          },
        ),
      ),
    );
  }
}

class ChannelView extends StatelessWidget {
  final YoutubeChannel channel;
  final PaginatedUiResource<YoutubePlaylist> playlistsResource;

  const ChannelView({
    super.key,
    required this.channel,
    required this.playlistsResource,
  });

  void _navigateToUploads(BuildContext context) {
    Navigator.of(context).pushNamed(
      PlaylistPage.routeName,
      arguments: PlaylistPageArguments(
        onGenerateTitle: (context) =>
            YoutubeStrings.of(context).uploadedVideosCaption,
        playlistId: channel.uploadsPlaylistId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: ChannelInfo(
            channel: channel,
          ),
        ),
        const SliverToBoxAdapter(child: Divider(height: 1)),
        SliverToBoxAdapter(
          child: ListTile(
            leading: const Icon(Icons.cloud_upload_rounded),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            title: Text(YoutubeStrings.of(context).uploadedVideosCaption),
            onTap: () => _navigateToUploads(context),
          ),
        ),
        const SliverToBoxAdapter(child: Divider(height: 1)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              YoutubeStrings.of(context).playlistsCaption,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: PagedSliverList(
            pagingController: playlistsResource.controller,
            builderDelegate: PagedChildBuilderDelegate<YoutubePlaylist>(
              itemBuilder: (_, item, __) {
                return YoutubePlaylistListTile(playlist: item);
              },
            ),
          ),
        ),
      ],
    );
  }
}
