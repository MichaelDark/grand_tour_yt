import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart' show YouTubeApi;
import 'package:injectable/injectable.dart';

import '../models/youtube/youtube_channel.dart';
import '../models/youtube/youtube_playlist.dart';
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
      ['snippet', 'contentDetails', 'statistics', 'status'],
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
      ['contentDetails', 'id', 'localizations', 'player', 'snippet', 'status'],
      channelId: channelId,
      pageToken: pageToken,
    );
    return _mapper.mapPlaylistResponse(response);
  }

  Future<YoutubeResponse<YoutubeVideo>> fetchPlaylistPage(
    String id,
    String? pageToken,
  ) async {
    final api = await getApi();
    final response = await api.playlistItems.list(
      ['contentDetails', 'id', 'snippet', 'status'],
      playlistId: id,
      pageToken: pageToken,
    );
    return _mapper.mapPlaylistItemResponse(response);
  }
}
