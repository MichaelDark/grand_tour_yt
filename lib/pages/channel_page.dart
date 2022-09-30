import 'package:flutter/material.dart';

import '../di/locator.dart';
import '../providers/youtube_channel_view_model.dart';
import '../widgets/channel_description.dart';
import '../widgets/channel_image.dart';
import '../widgets/resource_builder.dart';
import '../widgets/tiles/playlist_item_list_tile.dart';
import '../widgets/tiles/playlist_list_tile.dart';

class ChannelPage extends StatefulWidget {
  static const routeName = '/channel';

  const ChannelPage({Key? key}) : super(key: key);

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  final YoutubeChannelViewModel _viewModel = locator<YoutubeChannelViewModel>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ResourceBuilder(
          resource: _viewModel.channelResource,
          builder: (context, channel) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Center(
                      child: ChannelImage(
                        imageUrl: channel.snippet!.thumbnails!.high!.url!,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ChannelDescription(
                      title: channel.snippet!.title!,
                      description: channel.snippet!.description!,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 16,
                        right: 16,
                      ),
                      child: Text(
                        'Playlists',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ResourceBuilder(
                      resource: _viewModel.playlistsResource,
                      builder: (context, playlists) {
                        return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            itemBuilder: (context, index) {
                              final playlist = playlists[index];

                              return PlaylistListTile(
                                playlist: playlist,
                              );
                            },
                            itemCount: playlists.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Builder(
                      builder: (context) {
                        final viewModelFactory =
                            locator<YoutubePlaylistViewModelFactory>();
                        final viewModel = viewModelFactory.create(
                            channel.contentDetails!.relatedPlaylists!.uploads!);
                        return ResourceBuilder(
                          resource: viewModel.playlistItemsResource,
                          builder: (context, playlistItems) {
                            return SizedBox(
                              height: 200,
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                itemBuilder: (context, index) {
                                  final playlistItem = playlistItems[index];

                                  return PlaylistItemListTile(
                                    playlistItem: playlistItem,
                                  );
                                },
                                itemCount: playlistItems.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            );
                          },
                        );
                      },
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
