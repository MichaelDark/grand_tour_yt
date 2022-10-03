import 'package:flutter/material.dart';

import '../di/locator.dart';
import '../models/youtube/youtube_channel.dart';
import '../view_models/channel_view_model.dart';
import '../widgets/resources/resource_builder.dart';
import '../widgets/tiles/youtube_channel_list_tile.dart';

class ChannelsPage extends StatelessWidget {
  static const routeName = '/channels';

  const ChannelsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModelFactory = locator<ChannelViewModelFactory>();
    const channelIds = YoutubeChannel.channels;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              leading: Icon(Icons.favorite_rounded),
              title: Text('My favourite YouTube channels'),
              pinned: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final channelId = channelIds[index];
                    final viewModel = viewModelFactory.get(channelId);
                    return ResourceBuilder<YoutubeChannel>(
                      resource: viewModel.channelResource,
                      builder: (context, channel) {
                        return YoutubeChannelListTile(channel: channel);
                      },
                    );
                  },
                  childCount: channelIds.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
