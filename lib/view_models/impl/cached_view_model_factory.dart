import 'package:injectable/injectable.dart';

import '../../services/youtube_service.dart';
import '../../utils/youtube_constants.dart';
import '../view_model_factory.dart';
import '../view_model_models.dart';
import 'youtube_service_view_models.dart';

@LazySingleton(as: ViewModelFactory)
class CachedViewModelFactory implements ViewModelFactory {
  final YoutubeService _service;

  CachedViewModelFactory(this._service);

  @override
  List<String> get channelIds => YoutubeConstants.channels;

  final Map<String, ChannelViewModel> _channelCache = {};
  final Map<String, PlaylistViewModel> _playlistCache = {};
  final Map<String, VideoViewModel> _videoCache = {};
  final Map<String, Map<String, VideoSearchViewModel>> _videoSearchCache = {};

  @override
  ChannelViewModel channel(String channelId) {
    _channelCache[channelId] ??= YoutubeServiceChannelViewModel(
      _service,
      channelId,
    );
    return _channelCache[channelId]!;
  }

  @override
  PlaylistViewModel playlist(String playlistId) {
    _playlistCache[playlistId] ??= YoutubeServicePlaylistViewModel(
      _service,
      playlistId,
    );
    return _playlistCache[playlistId]!;
  }

  @override
  VideoViewModel video(String videoId) {
    _videoCache[videoId] ??= YoutubeServiceVideoViewModel(_service, videoId);
    return _videoCache[videoId]!;
  }

  @override
  VideoSearchViewModel videoSearch(String channelId, String query) {
    _videoSearchCache[channelId] ??= {};
    _videoSearchCache[channelId]![query] ??= YoutubeServiceVideoSearchViewModel(
      _service,
      channelId,
      query,
    );
    return _videoSearchCache[channelId]![query]!;
  }
}
