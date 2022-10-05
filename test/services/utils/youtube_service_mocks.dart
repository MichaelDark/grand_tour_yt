import 'package:googleapis/youtube/v3.dart';
import 'package:grandtouryt/models/youtube/youtube_channel.dart';
import 'package:grandtouryt/models/youtube/youtube_playlist.dart';
import 'package:grandtouryt/models/youtube/youtube_playlist_item.dart';
import 'package:grandtouryt/models/youtube/youtube_response.dart';
import 'package:grandtouryt/models/youtube/youtube_thumbnail.dart';
import 'package:grandtouryt/models/youtube/youtube_video.dart';
import 'package:grandtouryt/services/auth_service.dart';
import 'package:grandtouryt/services/impl/google_api_youtube_mapper.dart';
import 'package:grandtouryt/services/impl/google_api_youtube_service.dart';
import 'package:mocktail/mocktail.dart';

import 'general_mocks.dart';

/// Mock for `googleapis`
class MockYoutubeApi extends Mock implements YouTubeApi {}

/// Mock for `googleapis`
class MockChannelsResource extends Mock implements ChannelsResource {}

/// Mock for `googleapis`
class MockVideosResource extends Mock implements VideosResource {}

/// Mock for `googleapis`
class MockPlaylistsResource extends Mock implements PlaylistsResource {}

/// Mock for `googleapis`
class MockPlaylistItemsResource extends Mock implements PlaylistItemsResource {}

/// Mock for `googleapis`
class MockSearchResource extends Mock implements SearchResource {}

/// Mock for app service
class MockAuthService extends Mock implements AuthService {}

/// Mock for app service
class MockGoogleApiYoutubeService extends GoogleApiYoutubeService {
  final YouTubeApi? api;

  MockGoogleApiYoutubeService.withApi({
    required this.api,
  }) : super(
          MockLogger(),
          MockAuthService(),
          GoogleApiYoutubeMapper(),
        );

  MockGoogleApiYoutubeService.withAuthService({
    required AuthService authService,
  })  : api = null,
        super(
          MockLogger(),
          authService,
          GoogleApiYoutubeMapper(),
        );

  @override
  Future<YouTubeApi> getApi() async => api ?? await super.getApi();
}

/// Mock data for testing
class MockMethodCallData<I, R> {
  final I invalidInput;
  final I validInput;
  final R output;

  const MockMethodCallData({
    required this.invalidInput,
    required this.validInput,
    required this.output,
  });

  static final channelCall = MockMethodCallData(
    invalidInput: ChannelListResponse(items: [Channel()]),
    validInput: ChannelListResponse(items: [
      Channel(
        id: 'mock',
        snippet: ChannelSnippet(
          title: 'title',
          description: 'desc',
          thumbnails: ThumbnailDetails(
            high: Thumbnail(url: 'url'),
          ),
        ),
        contentDetails: ChannelContentDetails(
          relatedPlaylists: ChannelContentDetailsRelatedPlaylists(
            uploads: 'id',
          ),
        ),
        statistics: ChannelStatistics(
          subscriberCount: '123',
          videoCount: '456',
        ),
      ),
    ]),
    output: const YoutubeChannel(
      id: 'mock',
      title: 'title',
      description: 'desc',
      uploadsPlaylistId: 'id',
      subscriberCount: 123,
      videoCount: 456,
      thumbnail: YoutubeThumbnail(
        imageUrl: 'url',
      ),
    ),
  );

  static final videoCall = MockMethodCallData(
    invalidInput: VideoListResponse(items: [Video()]),
    validInput: VideoListResponse(
      items: [
        Video(
          id: 'videoId',
          snippet: VideoSnippet(
            title: 'title',
            description: 'desc',
            thumbnails: ThumbnailDetails(
              high: Thumbnail(url: 'url'),
            ),
            publishedAt: DateTime(2000, 1, 1),
          ),
          contentDetails: VideoContentDetails(
            licensedContent: true,
            duration: 'PT1M2S',
          ),
          statistics: VideoStatistics(
            commentCount: '12',
            likeCount: '23',
            viewCount: '34',
          ),
        ),
      ],
      nextPageToken: 'token',
    ),
    output: YoutubeVideo(
      id: 'videoId',
      title: 'title',
      description: 'desc',
      thumbnail: const YoutubeThumbnail(
        imageUrl: 'url',
      ),
      publishedAt: DateTime(2000, 1, 1),
      duration: const Duration(minutes: 1, seconds: 2),
      licensedContent: true,
      commentCount: 12,
      likeCount: 23,
      viewCount: 34,
    ),
  );

  static final playlistsCall = MockMethodCallData(
    invalidInput: PlaylistListResponse(items: [Playlist()]),
    validInput: PlaylistListResponse(
      items: [
        Playlist(
          id: 'mock',
          snippet: PlaylistSnippet(
            title: 'title',
            description: 'desc',
            thumbnails: ThumbnailDetails(
              high: Thumbnail(url: 'url'),
            ),
          ),
        ),
      ],
      nextPageToken: 'token',
    ),
    output: const YoutubeResponse(
      items: [
        YoutubePlaylist(
          id: 'mock',
          title: 'title',
          description: 'desc',
          thumbnail: YoutubeThumbnail(
            imageUrl: 'url',
          ),
        ),
      ],
      nextPageToken: 'token',
    ),
  );

  static final playlistItemsCall = MockMethodCallData(
    invalidInput: PlaylistItemListResponse(items: [PlaylistItem()]),
    validInput: PlaylistItemListResponse(
      items: [
        PlaylistItem(
          id: 'mock',
          snippet: PlaylistItemSnippet(
            title: 'title',
            description: 'desc',
            thumbnails: ThumbnailDetails(
              high: Thumbnail(url: 'url'),
            ),
          ),
          contentDetails: PlaylistItemContentDetails(
            videoId: 'videoId',
            videoPublishedAt: DateTime(2000, 1, 1),
          ),
        ),
      ],
      nextPageToken: 'token',
    ),
    output: YoutubeResponse(
      items: [
        YoutubePlaylistItem(
          id: 'mock',
          title: 'title',
          description: 'desc',
          thumbnail: const YoutubeThumbnail(
            imageUrl: 'url',
          ),
          videoId: 'videoId',
          publishedAt: DateTime(2000, 1, 1),
        ),
      ],
      nextPageToken: 'token',
    ),
  );

  static final searchCall = MockMethodCallData(
    invalidInput: SearchListResponse(items: [SearchResult()]),
    validInput: SearchListResponse(
      items: [
        SearchResult(
          id: ResourceId(videoId: 'videoId'),
          snippet: SearchResultSnippet(
            title: 'title',
            description: 'desc',
            thumbnails: ThumbnailDetails(
              high: Thumbnail(url: 'url'),
            ),
            publishedAt: DateTime(2000, 1, 1),
          ),
        ),
      ],
      nextPageToken: 'token',
    ),
    output: YoutubeResponse(
      items: [
        YoutubePlaylistItem(
          id: 'videoId',
          title: 'title',
          description: 'desc',
          thumbnail: const YoutubeThumbnail(
            imageUrl: 'url',
          ),
          videoId: 'videoId',
          publishedAt: DateTime(2000, 1, 1),
        ),
      ],
      nextPageToken: 'token',
    ),
  );
}
