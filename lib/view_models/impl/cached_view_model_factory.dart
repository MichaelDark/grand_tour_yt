import 'package:flutter/foundation.dart' show visibleForTesting;
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

  /// Channel ID as a key
  final Map<String, ChannelViewModel> _channelCache = {};

  /// Playlist ID as a key
  final Map<String, PlaylistViewModel> _playlistCache = {};

  /// Video ID as a key
  final Map<String, VideoViewModel> _videoCache = {};

  /// Channel ID as a first key,
  /// query as a second key
  final Map<String, Map<String, VideoSearchViewModel>> _videoSearchCache = {};

  @override
  ChannelViewModel channel(String channelId) {
    _channelCache[channelId] ??= createChannel(channelId);
    return _channelCache[channelId]!;
  }

  @visibleForTesting
  ChannelViewModel createChannel(String channelId) {
    return YoutubeServiceChannelViewModel(_service, channelId);
  }

  @override
  PlaylistViewModel playlist(String playlistId) {
    _playlistCache[playlistId] ??= createPlaylist(playlistId);
    return _playlistCache[playlistId]!;
  }

  @visibleForTesting
  PlaylistViewModel createPlaylist(String playlistId) {
    return YoutubeServicePlaylistViewModel(_service, playlistId);
  }

  @override
  VideoViewModel video(String videoId) {
    _videoCache[videoId] ??= createVideo(videoId);
    return _videoCache[videoId]!;
  }

  @visibleForTesting
  VideoViewModel createVideo(String videoId) {
    return YoutubeServiceVideoViewModel(_service, videoId);
  }

  @override
  VideoSearchViewModel videoSearch(String channelId, String q) {
    _videoSearchCache[channelId] ??= {};
    _videoSearchCache[channelId]![q] ??= createVideoSearch(channelId, q);
    return _videoSearchCache[channelId]![q]!;
  }

  @visibleForTesting
  VideoSearchViewModel createVideoSearch(String channelId, String q) {
    return YoutubeServiceVideoSearchViewModel(_service, channelId, q);
  }
}
