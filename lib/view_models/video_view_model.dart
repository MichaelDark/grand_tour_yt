import 'package:injectable/injectable.dart';

import '../models/resources/impl/ui_future_resource.dart';
import '../models/resources/ui_resource.dart';
import '../models/youtube/youtube_video.dart';
import '../services/youtube_service.dart';

@lazySingleton
class VideoViewModelFactory {
  final YoutubeService _service;

  VideoViewModelFactory(this._service);

  final Map<String, VideoViewModel> _cache = {};

  VideoViewModel get(String videoId) {
    if (!_cache.containsKey(videoId)) {
      _cache[videoId] = VideoViewModel(_service, videoId);
    }
    return _cache[videoId]!;
  }
}

class VideoViewModel {
  final UiResource<YoutubeVideo> videoResource;

  VideoViewModel(YoutubeService service, String videoId)
      : videoResource = UiFutureResource(
          () => service.fetchVideo(videoId),
        );
}
