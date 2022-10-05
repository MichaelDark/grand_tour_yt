import 'package:flutter_test/flutter_test.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:grandtouryt/models/youtube/youtube_channel.dart';
import 'package:grandtouryt/models/youtube/youtube_playlist.dart';
import 'package:grandtouryt/models/youtube/youtube_playlist_item.dart';
import 'package:grandtouryt/models/youtube/youtube_response.dart';
import 'package:grandtouryt/models/youtube/youtube_video.dart';
import 'package:grandtouryt/services/impl/google_api_youtube_service.dart';
import 'package:mocktail/mocktail.dart';

import 'utils/youtube_service_mocks.dart';

extension on String {
  Symbol get sym => Symbol(this);
}

void main() {
  group('GoogleApiYoutubeService', () {
    test('#fetchChannel', () {
      final resource = MockChannelsResource();

      _test<ChannelsResource, ChannelListResponse, YoutubeChannel>(
        resource: resource,
        resourceGetterInvocation: (api) => () => api.channels,
        resourceInvocation: () => resource.list(
          any(),
          id: any(named: 'id'),
          maxResults: any(named: 'maxResults'),
        ),
        isValid: (i) => i.namedArguments['id'.sym]?.first == 'validId',
        call: MockMethodCallData.channelCall,
        validInvocation: (service) => service.fetchChannel('validId'),
        invalidInvocation: (service) => service.fetchChannel('invalidId'),
      );
    });

    test('#fetchVideo', () {
      final resource = MockVideosResource();

      _test<VideosResource, VideoListResponse, YoutubeVideo>(
        resource: resource,
        resourceGetterInvocation: (api) => () => api.videos,
        resourceInvocation: () => resource.list(
          any(),
          id: any(named: 'id'),
          maxResults: any(named: 'maxResults'),
        ),
        isValid: (i) => i.namedArguments['id'.sym]?.first == 'validId',
        call: MockMethodCallData.videoCall,
        validInvocation: (s) => s.fetchVideo('validId'),
        invalidInvocation: (s) => s.fetchVideo('invalidId'),
      );
    });

    test('#fetchPlaylistsPage', () {
      final resource = MockPlaylistsResource();

      _test<PlaylistsResource, PlaylistListResponse,
          YoutubeResponse<YoutubePlaylist>>(
        resource: resource,
        resourceGetterInvocation: (api) => () => api.playlists,
        resourceInvocation: () => resource.list(
          any(),
          channelId: any(named: 'channelId'),
          pageToken: any(named: 'pageToken'),
        ),
        isValid: (i) => i.namedArguments['channelId'.sym] == 'validId',
        call: MockMethodCallData.playlistsCall,
        validInvocation: (s) => s.fetchPlaylistsPage('validId', 'token'),
        invalidInvocation: (s) => s.fetchPlaylistsPage('invalidId', 'token'),
      );
    });

    test('#fetchPlaylistPage', () {
      final resource = MockPlaylistItemsResource();

      _test<PlaylistItemsResource, PlaylistItemListResponse,
          YoutubeResponse<YoutubePlaylistItem>>(
        resource: resource,
        resourceGetterInvocation: (api) => () => api.playlistItems,
        resourceInvocation: () => resource.list(
          any(),
          playlistId: any(named: 'playlistId'),
          pageToken: any(named: 'pageToken'),
        ),
        isValid: (i) => i.namedArguments['playlistId'.sym] == 'validId',
        call: MockMethodCallData.playlistItemsCall,
        validInvocation: (s) => s.fetchPlaylistPage('validId', 'token'),
        invalidInvocation: (s) => s.fetchPlaylistPage('invalidId', 'token'),
      );
    });

    test('#searchVideos', () {
      final resource = MockSearchResource();

      _test<SearchResource, SearchListResponse,
          YoutubeResponse<YoutubePlaylistItem>>(
        resource: resource,
        resourceGetterInvocation: (api) => () => api.search,
        resourceInvocation: () => resource.list(
          any(),
          channelId: any(named: 'channelId'),
          q: any(named: 'q'),
          type: any(named: 'type'),
          pageToken: any(named: 'pageToken'),
        ),
        isValid: (i) => i.namedArguments['channelId'.sym] == 'validId',
        call: MockMethodCallData.searchCall,
        validInvocation: (s) => s.searchVideos('validId', 'q', 'token'),
        invalidInvocation: (s) => s.searchVideos('invalidId', 'q', 'token'),
      );
    });
  });
}

void _test<T, I, R>({
  required T resource,
  required T Function() Function(YouTubeApi) resourceGetterInvocation,
  required Future<I> Function() resourceInvocation,
  required bool Function(Invocation) isValid,
  required MockMethodCallData<I, R> call,
  required Future<R> Function(GoogleApiYoutubeService) validInvocation,
  required Future<R> Function(GoogleApiYoutubeService) invalidInvocation,
}) {
  const authError = '42';
  final authService = MockAuthService();
  when(() => authService.createAuthenticatedHttpClient())
      .thenAnswer((_) => throw authError);

  final serviceWithAuthService = MockGoogleApiYoutubeService.withAuthService(
    authService: authService,
  );

  /// Test that invocation fails if cannot create HTTP client
  expect(validInvocation(serviceWithAuthService), throwsA(equals(authError)));

  final api = MockYoutubeApi();
  when(resourceGetterInvocation(api)).thenReturn(resource);
  when(resourceInvocation).thenAnswer((Invocation invocation) async {
    return isValid(invocation) ? call.validInput : call.invalidInput;
  });
  final serviceWithApi = MockGoogleApiYoutubeService.withApi(api: api);

  /// Test that invocation returns normally if data is valid
  expect(validInvocation(serviceWithApi), completion(call.output));

  /// Test that invocation fail if data is invalid
  expect(invalidInvocation(serviceWithApi), throwsException);
}
