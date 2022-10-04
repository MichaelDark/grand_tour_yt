import 'package:injectable/injectable.dart';

import '../models/resources/paginated_ui_resource.dart';
import '../models/resources/paginated_youtube_ui_resource.dart';
import '../models/youtube/youtube_playlist_item.dart';
import '../services/youtube_service.dart';

@lazySingleton
class VideoSearchViewModelFactory {
  final YoutubeService _service;

  VideoSearchViewModelFactory(this._service);

  final Map<String, Map<String, VideoSearchViewModel>> _cache = {};

  VideoSearchViewModel get(String channelId, String query) {
    if (!_cache.containsKey(channelId)) {
      _cache[channelId] ??= {};
    }
    if (!_cache[channelId]!.containsKey(query)) {
      _cache[channelId]![query] = VideoSearchViewModel(
        _service,
        channelId,
        query,
      );
    }
    return _cache[channelId]![query]!;
  }
}

class VideoSearchViewModel {
  final PaginatedUiResource<YoutubePlaylistItem> searchResultResource;

  VideoSearchViewModel(YoutubeService service, String channelId, String query)
      : searchResultResource = PaginatedYoutubeUiResource(
          (pageToken) => service.searchVideos(channelId, query, pageToken),
        );
}
