import 'package:googleapis/youtube/v3.dart';
import 'package:injectable/injectable.dart';

import '../models/ui_resource.dart';
import '../services/youtube_service.dart';

@lazySingleton
class YoutubeChannelViewModel {
  UiResource<Channel> channelResource;
  UiResource<List<Playlist>> playlistsResource;

  YoutubeChannelViewModel(YoutubeService service)
      : channelResource = FutureUiResource(() => service.fetchChannel()),
        playlistsResource = FutureUiResource(() => service.fetchPlaylists());
}

@lazySingleton
class YoutubePlaylistViewModelFactory {
  final YoutubeService _service;

  YoutubePlaylistViewModelFactory(this._service);

  final Map<String, YoutubePlaylistViewModel> _cacheMap = {};

  YoutubePlaylistViewModel create(String playlistId) {
    if (!_cacheMap.containsKey(playlistId)) {
      _cacheMap[playlistId] = YoutubePlaylistViewModel(_service, playlistId);
    }
    return _cacheMap[playlistId]!;
  }
}

class YoutubePlaylistViewModel {
  UiResource<List<PlaylistItem>> playlistItemsResource;

  YoutubePlaylistViewModel(YoutubeService service, String playlistId)
      : playlistItemsResource =
            FutureUiResource(() => service.fetchPlaylist(playlistId));
}
