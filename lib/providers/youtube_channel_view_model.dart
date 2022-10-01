import 'package:googleapis/youtube/v3.dart';
import 'package:injectable/injectable.dart';

import '../models/paginated_ui_resource.dart';
import '../models/ui_resource.dart';
import '../services/youtube_service.dart';

@lazySingleton
class YoutubeChannelViewModel {
  UiResource<Channel> channelResource;
  PagintatedUiResource<Playlist, String?> playlistsResource;

  YoutubeChannelViewModel(YoutubeService service)
      : channelResource = FutureUiResource(() => service.fetchChannel()),
        playlistsResource = YoutubePagintatedUiResource(
          (pageToken) => service.fetchPlaylistsPage(pageToken),
          nextPageTokenExtractor: (r) => r.nextPageToken,
          listExtractor: (r) => r.items!,
        );
}

@lazySingleton
class YoutubePlaylistViewModelFactory {
  final YoutubeService _service;

  YoutubePlaylistViewModelFactory(this._service);

  final Map<String, PaginatedYoutubePlaylistViewModel> _paginatedCacheMap = {};

  PaginatedYoutubePlaylistViewModel createPaginated(String playlistId) {
    if (!_paginatedCacheMap.containsKey(playlistId)) {
      _paginatedCacheMap[playlistId] =
          PaginatedYoutubePlaylistViewModel(_service, playlistId);
    }
    return _paginatedCacheMap[playlistId]!;
  }
}

class PaginatedYoutubePlaylistViewModel {
  PagintatedUiResource<PlaylistItem, String?> playlistItemsResource;

  PaginatedYoutubePlaylistViewModel(YoutubeService service, String playlistId)
      : playlistItemsResource = YoutubePagintatedUiResource(
          (pageToken) => service.fetchPlaylistPage(playlistId, pageToken),
          nextPageTokenExtractor: (r) => r.nextPageToken,
          listExtractor: (r) => r.items!,
        );
}
