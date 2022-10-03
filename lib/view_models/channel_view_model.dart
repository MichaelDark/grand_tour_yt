import 'package:injectable/injectable.dart';

import '../models/resources/paginated_ui_resource.dart';
import '../models/resources/paginated_youtube_ui_resource.dart';
import '../models/resources/ui_future_resource.dart';
import '../models/resources/ui_resource.dart';
import '../models/youtube/youtube_channel.dart';
import '../models/youtube/youtube_playlist.dart';
import '../services/youtube_service.dart';

@lazySingleton
class ChannelViewModelFactory {
  final YoutubeService _service;

  ChannelViewModelFactory(this._service);

  final Map<String, ChannelViewModel> _cache = {};

  ChannelViewModel get(String channelId) {
    if (!_cache.containsKey(channelId)) {
      _cache[channelId] = ChannelViewModel(_service, channelId);
    }
    return _cache[channelId]!;
  }
}

class ChannelViewModel {
  final UiResource<YoutubeChannel> channelResource;
  final PaginatedUiResource<YoutubePlaylist> playlistsResource;

  ChannelViewModel(YoutubeService service, String channelId)
      : channelResource = UiFutureResource(
          () => service.fetchChannel(channelId),
        ),
        playlistsResource = PaginatedYoutubeUiResource(
          (pageToken) => service.fetchPlaylistsPage(channelId, pageToken),
        );
}
