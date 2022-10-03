import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart' show YouTubeApi;
import 'package:injectable/injectable.dart';

import '../models/youtube/youtube_channel.dart';
import '../models/youtube/youtube_playlist.dart';
import '../models/youtube/youtube_playlist_item.dart';
import '../models/youtube/youtube_response.dart';
import '../models/youtube/youtube_video.dart';
import 'google_auth_service.dart';
import 'youtube_mapper.dart';

@singleton
class YoutubeService {
  final GoogleAuthService _authService;
  final YoutubeMapper _mapper;

  YoutubeService(this._authService, this._mapper);

  Future<YouTubeApi>? _youtubeApi;

  @visibleForTesting
  Future<YouTubeApi> getApi() async {
    _youtubeApi ??= createApi();
    return _youtubeApi!;
  }

  @visibleForTesting
  Future<YouTubeApi> createApi() async {
    final client = await _authService.createAuthenticatedHttpClient();
    if (client == null) {
      throw Exception('Cannot create HTTP Client for Youtube API :(');
    }
    return YouTubeApi(client);
  }

  Future<YoutubeChannel> fetchChannel(String channelId) async {
    final api = await getApi();
    final response = await api.channels.list(
      Parts.channels,
      id: [channelId],
      maxResults: 1,
    );
    return _mapper.mapChannel(response);
  }

  Future<YoutubeResponse<YoutubePlaylist>> fetchPlaylistsPage(
    String channelId,
    String? pageToken,
  ) async {
    final api = await getApi();
    final response = await api.playlists.list(
      Parts.playlists,
      channelId: channelId,
      pageToken: pageToken,
    );
    return _mapper.mapPlaylistResponse(response);
  }

  Future<YoutubeResponse<YoutubePlaylistItem>> fetchPlaylistPage(
    String id,
    String? pageToken,
  ) async {
    final api = await getApi();
    final response = await api.playlistItems.list(
      Parts.playlist,
      playlistId: id,
      pageToken: pageToken,
    );
    return _mapper.mapPlaylistItemResponse(response);
  }

  Future<YoutubeVideo> fetchVideo(String id) async {
    final api = await getApi();
    final response = await api.videos.list(
      Parts.video,
      id: [id],
    );
    return _mapper.mapVideo(response);
  }
}

abstract class Parts {
  static const channels = [
    'snippet',
    'contentDetails',
    'statistics',

    // unused
    // 'status',
  ];
  static const playlists = [
    'id',
    'snippet',

    // unused
    // 'contentDetails',
    // 'localizations',
    // 'player',
    // 'status',
  ];
  static const playlist = [
    'contentDetails',
    'id',
    'snippet',
    // unused
    // 'status',
  ];
  static const video = [
    'contentDetails',
    'id',
    'snippet',
    'statistics',

    // unused
    // 'liveStreamingDetails',
    // 'localizations',
    // 'player',
    // 'recordingDetails',
    // 'status',
    // 'topicDetails',

    // available only for file owner
    // 'fileDetails',
    // 'processingDetails',
    // 'suggestions',
  ];
}
