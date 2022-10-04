import 'package:flutter/material.dart';

import '../di/locator.dart';
import '../l10n/youtube_strings.dart';
import '../models/youtube/youtube_channel.dart';
import '../models/youtube/youtube_playlist.dart';
import '../utils/build_context_ext.dart';
import '../view_models/view_model_factory.dart';
import '../view_models/view_model_models.dart';
import '../widgets/resources/resource_builder.dart';
import '../widgets/show_up.dart';
import '../widgets/slivers/sliver_channel_app_bar.dart';
import '../widgets/slivers/sliver_paged_image_tile_list.dart';
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
    final viewModel = locator<ViewModelFactory>().channel(args.channelId);

    return SafeArea(
      child: Scaffold(
        body: ResourceBuilder(
          resource: viewModel.channelResource,
          builder: (context, channel) {
            return ChannelPageContent(
              channel: channel,
              viewModel: viewModel,
            );
          },
        ),
      ),
    );
  }
}

class ChannelPageContent extends StatelessWidget {
  final YoutubeChannel channel;
  final ChannelViewModel viewModel;

  const ChannelPageContent({
    super.key,
    required this.channel,
    required this.viewModel,
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
        SliverChannelAppBar(
          channel: channel,
          expandedHeight: SliverChannelAppBar.calculateAppBarHeight(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(4).add(const EdgeInsets.only(top: 8)),
          sliver: SliverToBoxAdapter(
            child: ShowUp(
              child: _ChannelCountersInfoView(channel: channel),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: ShowUp(
              delay: const Duration(milliseconds: 200),
              child: _ChannelTextInfoView(channel: channel),
            ),
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
        SliverPagedImageTileList<YoutubePlaylist>(
          resource: viewModel.playlistsResource,
          builder: (_, item, __) => YoutubePlaylistListTile(playlist: item),
        ),
      ],
    );
  }
}

class _ChannelCountersInfoView extends StatelessWidget {
  final YoutubeChannel channel;

  const _ChannelCountersInfoView({
    Key? key,
    required this.channel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          YoutubeStrings.of(context).nSubscribers(channel.subscriberCount!),
          style: Theme.of(context).textTheme.caption,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            ' • ',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Text(
          YoutubeStrings.of(context).nVideos(channel.videoCount!),
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class _ChannelTextInfoView extends StatelessWidget {
  final YoutubeChannel channel;

  const _ChannelTextInfoView({
    Key? key,
    required this.channel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      channel.description,
      style: Theme.of(context).textTheme.caption,
    );
  }
}
