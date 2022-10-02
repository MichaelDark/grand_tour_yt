import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';

import '../di/locator.dart';
import '../models/paginated_ui_resource.dart';
import '../providers/youtube_channel_view_model.dart';
import '../widgets/channel_description.dart';
import '../widgets/channel_image.dart';
import '../widgets/paginated_horizontal_list.dart';
import '../widgets/resource_builder.dart';
import '../widgets/tiles/playlist_list_tile.dart';
import 'playlist_page.dart';

class ChannelPage extends StatelessWidget {
  static const routeName = '/channel';

  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = locator<YoutubeChannelViewModel>();

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
  final Channel channel;
  final PagintatedUiResource<Playlist, String?> playlistsResource;

  const ChannelView({
    super.key,
    required this.channel,
    required this.playlistsResource,
  });

  @override
  Widget build(BuildContext context) {
    final viewModelFactory = locator<YoutubePlaylistViewModelFactory>();
    final uploadsId = channel.contentDetails!.relatedPlaylists!.uploads!;
    final uploadsViewModel = viewModelFactory.createPaginated(uploadsId);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: ChannelImage(
              thumbnailDetails: channel.snippet!.thumbnails!,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ChannelDescription(
            title: channel.snippet!.title!,
            description: channel.snippet!.description!,
          ),
        ),
        const SliverToBoxAdapter(child: Divider(height: 1)),
        SliverToBoxAdapter(
          child: ListTile(
            leading: const Icon(Icons.cloud_upload_rounded),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            title: const Text('Uploaded videos'),
            onTap: () {
              Navigator.of(context).pushNamed(
                PlaylistPage.routeName,
                arguments: PlaylistPageArguments(
                  title: 'Uploaded videos',
                  playlistId: uploadsId,
                ),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: Divider(height: 1)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
            child: Text(
              'Playlists',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: PaginatedHorizontalList<Playlist>(
            pagintatedResource: playlistsResource,
            itemBuilder: (_, item, __) {
              return PlaylistListTile(playlist: item);
            },
          ),
        ),
      ],
    );
  }
}
