import 'package:flutter/material.dart';

import '../di/locator.dart';
import '../l10n/youtube_strings.dart';
import '../models/youtube/youtube_channel.dart';
import '../view_models/view_model_factory.dart';
import '../widgets/resources/resource_builder.dart';
import '../widgets/tiles/image_list_tile_error.dart';
import '../widgets/tiles/image_list_tile_shimmer.dart';
import '../widgets/tiles/youtube_channel_list_tile.dart';
import 'settings_page.dart';

class ChannelsPage extends StatelessWidget {
  static const routeName = '/channels';

  const ChannelsPage({Key? key}) : super(key: key);

  void _navigateToSettings(BuildContext context) {
    Navigator.of(context).pushNamed(SettingsPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final viewModelFactory = locator<ViewModelFactory>();

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: const Icon(Icons.favorite_rounded),
              title: Text(YoutubeStrings.of(context).channelsPageTitle),
              actions: [
                IconButton(
                  onPressed: () => _navigateToSettings(context),
                  icon: const Icon(Icons.settings_rounded),
                ),
              ],
              pinned: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final channelId = viewModelFactory.channelIds[index];
                    final viewModel = viewModelFactory.channel(channelId);
                    return ResourceBuilder<YoutubeChannel>(
                      resource: viewModel.channelResource,
                      loadingBuilder: (context) {
                        return const ImageListTileShimmer();
                      },
                      errorBuilder: (context, error, retry) {
                        return ImageListTileError(error: error, retry: retry);
                      },
                      builder: (context, channel) {
                        return YoutubeChannelListTile(channel: channel);
                      },
                    );
                  },
                  childCount: viewModelFactory.channelIds.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
