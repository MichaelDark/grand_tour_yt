import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart' show YouTubeApi;
import 'package:injectable/injectable.dart';

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
  final AuthService _authService;
  final GoogleApiYoutubeMapper _mapper;

  GoogleApiYoutubeService(this._authService, this._mapper);

  @visibleForTesting
  Future<YouTubeApi> getApi() async {
    final client = await _authService.createAuthenticatedHttpClient();
    if (client == null) {
      throw Exception('Cannot create HTTP Client for Youtube API :(');
    }
    return YouTubeApi(client);
  }

  @override
  Future<YoutubeChannel> fetchChannel(String channelId) async {
    final api = await getApi();
    final response = await api.channels.list(
      YoutubeConstants.parts.channels,
      id: [channelId],
      maxResults: 1,
    );
    return _mapper.mapChannel(response);
  }

  @override
  Future<YoutubeVideo> fetchVideo(String id) async {
    final api = await getApi();
    final response = await api.videos.list(
      YoutubeConstants.parts.video,
      id: [id],
    );
    return _mapper.mapVideo(response);
  }

  @override
  Future<YoutubeResponse<YoutubePlaylist>> fetchPlaylistsPage(
    String channelId,
    String? pageToken,
  ) async {
    final api = await getApi();
    final response = await api.playlists.list(
      YoutubeConstants.parts.playlists,
      channelId: channelId,
      pageToken: pageToken,
    );
    return _mapper.mapPlaylistResponse(response);
  }

  @override
  Future<YoutubeResponse<YoutubePlaylistItem>> fetchPlaylistPage(
    String playlistId,
    String? pageToken,
  ) async {
    final api = await getApi();
    final response = await api.playlistItems.list(
      YoutubeConstants.parts.playlist,
      playlistId: playlistId,
      pageToken: pageToken,
    );
    return _mapper.mapPlaylistItemResponse(response);
  }

  @override
  Future<YoutubeResponse<YoutubePlaylistItem>> searchVideos(
    String channelId,
    String query,
    String? pageToken,
  ) async {
    final api = await getApi();
    final response = await api.search.list(
      YoutubeConstants.parts.search,
      channelId: channelId,
      q: query,
      type: ['video'],
      pageToken: pageToken,
    );
    return _mapper.mapSearchListResponse(response);
  }
}
