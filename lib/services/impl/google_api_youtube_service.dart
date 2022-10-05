import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart' show YouTubeApi;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../models/youtube/youtube_channel.dart';
import '../../models/youtube/youtube_playlist.dart';
import '../../models/youtube/youtube_playlist_item.dart';
import '../../models/youtube/youtube_response.dart';
import '../../models/youtube/youtube_video.dart';
import '../../utils/youtube_constants.dart';
import '../auth_service.dart';
import '../youtube_service.dart';
import 'google_api_youtube_mapper.dart';

@Singleton(as: YoutubeService)
class GoogleApiYoutubeService implements YoutubeService {
  final Logger _logger;
  final AuthService _authService;
  final GoogleApiYoutubeMapper _mapper;

  GoogleApiYoutubeService(this._logger, this._authService, this._mapper);

  @visibleForTesting
  Future<YouTubeApi> getApi() async {
    final client = await _authService.createAuthenticatedHttpClient();

    if (client == null) {
      const m = 'Cannot create HTTP Client for Youtube API';
      final e = Exception(m);
      final s = StackTrace.current;
      _logger.e(m, e, s);
      throw e;
    }
    return YouTubeApi(client);
  }

  @override
  Future<YoutubeChannel> fetchChannel(String channelId) async {
    try {
      final api = await getApi();
      final response = await api.channels.list(
        YoutubeConstants.parts.channels,
        id: [channelId],
        maxResults: 1,
      );
      return _mapper.mapChannel(response);
    } catch (e, s) {
      _logger.e('Error fetching YouTube channel with {id: $channelId}', e, s);
      rethrow;
    }
  }

  @override
  Future<YoutubeVideo> fetchVideo(String id) async {
    try {
      final api = await getApi();
      final response = await api.videos.list(
        YoutubeConstants.parts.video,
        id: [id],
      );
      return _mapper.mapVideo(response);
    } catch (e, s) {
      _logger.e('Error fetching YouTube video with {id: $id}', e, s);
      rethrow;
    }
  }

  @override
  Future<YoutubeResponse<YoutubePlaylist>> fetchPlaylistsPage(
    String channelId,
    String? pageToken,
  ) async {
    try {
      final api = await getApi();
      final response = await api.playlists.list(
        YoutubeConstants.parts.playlists,
        channelId: channelId,
        pageToken: pageToken,
      );
      return _mapper.mapPlaylistResponse(response);
    } catch (e, s) {
      _logger.e(
        'Error fetching YouTube playlists for {page: $pageToken} with {channelId: $channelId}',
        e,
        s,
      );
      rethrow;
    }
  }

  @override
  Future<YoutubeResponse<YoutubePlaylistItem>> fetchPlaylistPage(
    String playlistId,
    String? pageToken,
  ) async {
    try {
      final api = await getApi();
      final response = await api.playlistItems.list(
        YoutubeConstants.parts.playlist,
        playlistId: playlistId,
        pageToken: pageToken,
      );
      return _mapper.mapPlaylistItemResponse(response);
    } catch (e, s) {
      _logger.e(
        'Error fetching YouTube playlist items for {page: $pageToken} with {playlistId: $playlistId}',
        e,
        s,
      );
      rethrow;
    }
  }

  @override
  Future<YoutubeResponse<YoutubePlaylistItem>> searchVideos(
    String channelId,
    String query,
    String? pageToken,
  ) async {
    try {
      final api = await getApi();
      final response = await api.search.list(
        YoutubeConstants.parts.search,
        channelId: channelId,
        q: query,
        type: ['video'],
        pageToken: pageToken,
      );
      return _mapper.mapSearchListResponse(response);
    } catch (e, s) {
      _logger.e(
        'Error fetching YouTube video search for {page: $pageToken} with {channelId: $channelId, query: "$query"}',
        e,
        s,
      );
      rethrow;
    }
  }
}
