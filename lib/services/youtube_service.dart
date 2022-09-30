import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:grandtouryt/services/google_auth_service.dart';
import 'package:injectable/injectable.dart';
// ignore: depend_on_referenced_packages

@singleton
class YoutubeService {
  static const grandTourYoutubeChannelId = 'UCZ1Sc5xjWpUnp_o_lUTkvgQ';

  final GoogleAuthService _authService;
  Future<YouTubeApi>? _youtubeApi;

  YoutubeService(this._authService);

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

  Future<Channel> fetchChannel() async {
    final api = await getApi();
    final response = await api.channels.list(
      ['snippet', 'contentDetails', 'statistics', 'status'],
      id: [grandTourYoutubeChannelId],
      maxResults: 1,
    );
    final channel = response.items!.first;
    return channel;
  }

  Future<List<Playlist>> fetchPlaylists() async {
    final api = await getApi();
    List<Playlist> playlists = [];
    String? pageToken;
    do {
      final response = await api.playlists.list(
        [
          'contentDetails',
          'id',
          'localizations',
          'player',
          'snippet',
          'status',
        ],
        channelId: grandTourYoutubeChannelId,
        pageToken: pageToken,
      );
      playlists.addAll(response.items!);
      pageToken = response.nextPageToken;
    } while (pageToken != null);
    return playlists;
  }

  Future<List<PlaylistItem>> fetchPlaylist(String id) async {
    final api = await getApi();
    List<PlaylistItem> playlists = [];
    String? pageToken;
    do {
      final response = await api.playlistItems.list(
        [
          'contentDetails',
          'id',
          'snippet',
          'status',
        ],
        playlistId: id,
        pageToken: pageToken,
      );
      playlists.addAll(response.items!);
      pageToken = response.nextPageToken;
    } while (pageToken != null);
    return playlists;
  }

  Future<List<PlaylistItem>> fetchPlaylistPage(
    String id,
    String? pageToken,
  ) async {
    final api = await getApi();
    final response = await api.playlistItems.list(
      [
        'contentDetails',
        'id',
        'snippet',
        'status',
      ],
      playlistId: id,
      pageToken: pageToken,
    );
    return response.items!;
  }
}
