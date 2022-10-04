import 'package:injectable/injectable.dart';

import '../models/resources/impl/paginated_youtube_ui_resource.dart';
import '../models/resources/paginated_ui_resource.dart';
import '../models/youtube/youtube_playlist_item.dart';
import '../services/youtube_service.dart';

@lazySingleton
class PlaylistViewModelFactory {
  final YoutubeService _service;

  PlaylistViewModelFactory(this._service);

  final Map<String, PlaylistViewModel> _cache = {};

  PlaylistViewModel get(String playlistId) {
    if (!_cache.containsKey(playlistId)) {
      _cache[playlistId] = PlaylistViewModel(_service, playlistId);
    }
    return _cache[playlistId]!;
  }
}

class PlaylistViewModel {
  final PaginatedUiResource<YoutubePlaylistItem> playlistItemsResource;

  PlaylistViewModel(YoutubeService service, String playlistId)
      : playlistItemsResource = PaginatedYoutubeUiResource(
          (pageToken) => service.fetchPlaylistPage(playlistId, pageToken),
        );
}
