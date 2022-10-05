import 'package:flutter_test/flutter_test.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:grandtouryt/models/youtube/youtube_channel.dart';
import 'package:grandtouryt/models/youtube/youtube_playlist.dart';
import 'package:grandtouryt/models/youtube/youtube_playlist_item.dart';
import 'package:grandtouryt/models/youtube/youtube_response.dart';
import 'package:grandtouryt/models/youtube/youtube_thumbnail.dart';
import 'package:grandtouryt/models/youtube/youtube_video.dart';
import 'package:grandtouryt/services/impl/google_api_youtube_mapper.dart';

void main() {
  group('GoogleApiYoutubeMapper', () {
    final mapper = GoogleApiYoutubeMapper();

    group('#mapChannel', () {
      test('should fail if response is invalid', () {
        final invalidResponses = [
          ChannelListResponse(),
          ChannelListResponse(items: []),
          ChannelListResponse(items: [Channel()]),
          ChannelListResponse(items: [Channel(id: 'mock')]),
          ChannelListResponse(items: [
            Channel(
              id: 'mock',
              snippet: ChannelSnippet(title: 'title', description: 'desc'),
            ),
          ]),
          ChannelListResponse(items: [
            Channel(
              id: 'mock',
              snippet: ChannelSnippet(title: 'title', description: 'desc'),
              contentDetails: ChannelContentDetails(
                relatedPlaylists: ChannelContentDetailsRelatedPlaylists(
                  uploads: 'id',
                ),
              ),
            ),
          ]),
          ChannelListResponse(items: [
            Channel(
              id: 'mock',
              snippet: ChannelSnippet(title: 'title', description: 'desc'),
              contentDetails: ChannelContentDetails(
                relatedPlaylists: ChannelContentDetailsRelatedPlaylists(
                  uploads: 'id',
                ),
              ),
              statistics: ChannelStatistics(
                subscriberCount: 'text',
                videoCount: 'text',
              ),
            ),
          ]),
        ];

        for (final response in invalidResponses) {
          expect(() => mapper.mapChannel(response), throwsException);
        }
      });

      test('should parse valid response properly', () {
        final validResponse = ChannelListResponse(items: [
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
        ]);
        const expectedChannel = YoutubeChannel(
          id: 'mock',
          title: 'title',
          description: 'desc',
          uploadsPlaylistId: 'id',
          subscriberCount: 123,
          videoCount: 456,
          thumbnail: YoutubeThumbnail(
            imageUrl: 'url',
          ),
        );

        expect(mapper.mapChannel(validResponse), expectedChannel);
      });
    });

    group('#mapVideo', () {
      test('should fail if response is invalid', () {
        final invalidResponses = [
          VideoListResponse(),
          VideoListResponse(items: []),
          VideoListResponse(items: [Video()]),
          VideoListResponse(items: [
            Video(
              id: 'mock',
            ),
          ]),
          VideoListResponse(items: [
            Video(
              id: 'mock',
              snippet: VideoSnippet(title: 'title', description: 'desc'),
            ),
          ]),
          VideoListResponse(items: [
            Video(
              id: 'mock',
              snippet: VideoSnippet(
                title: 'title',
                description: 'desc',
                thumbnails: ThumbnailDetails(
                  high: Thumbnail(url: 'url'),
                ),
                publishedAt: DateTime(2000, 1, 1),
              ),
            ),
          ]),
          VideoListResponse(items: [
            Video(
              id: 'mock',
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
            ),
          ]),
          VideoListResponse(items: [
            Video(
              id: 'mock',
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
                commentCount: 'text',
                likeCount: 'text',
                viewCount: 'text',
              ),
            ),
          ]),
        ];

        for (final response in invalidResponses) {
          expect(
            () => mapper.mapVideo(response),
            throwsException,
          );
        }
      });

      test('should parse valid response properly', () {
        final validResponse = VideoListResponse(
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
        );

        final expectedChannel = YoutubeVideo(
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
        );

        expect(mapper.mapVideo(validResponse), expectedChannel);
      });
    });

    group('#mapPlaylistResponse', () {
      test('should fail if response is invalid', () {
        final invalidResponses = [
          PlaylistListResponse(items: [Playlist()]),
          PlaylistListResponse(items: [Playlist(id: 'mock')]),
          PlaylistListResponse(items: [
            Playlist(
              id: 'mock',
              snippet: PlaylistSnippet(title: null, description: null),
            ),
          ]),
        ];

        for (final response in invalidResponses) {
          expect(() => mapper.mapPlaylistResponse(response), throwsException);
        }
      });

      test('should parse valid response properly', () {
        expect(
          mapper.mapPlaylistResponse(PlaylistListResponse()),
          const YoutubeResponse(items: [], nextPageToken: null),
        );
        expect(
          mapper.mapPlaylistResponse(PlaylistListResponse(items: [])),
          const YoutubeResponse(items: [], nextPageToken: null),
        );

        final validResponse = PlaylistListResponse(
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
        );

        const expectedChannel = YoutubeResponse(
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
        );

        expect(mapper.mapPlaylistResponse(validResponse), expectedChannel);
      });
    });

    group('#mapPlaylistItemResponse', () {
      test('should fail if response is invalid', () {
        final invalidResponses = [
          PlaylistItemListResponse(items: [PlaylistItem()]),
          PlaylistItemListResponse(items: [PlaylistItem(id: 'mock')]),
          PlaylistItemListResponse(items: [
            PlaylistItem(
              id: 'mock',
              snippet: PlaylistItemSnippet(title: 'title', description: 'desc'),
            ),
          ]),
        ];

        for (final response in invalidResponses) {
          expect(
            () => mapper.mapPlaylistItemResponse(response),
            throwsException,
          );
        }
      });

      test('should parse valid response properly', () {
        expect(
          mapper.mapPlaylistItemResponse(PlaylistItemListResponse()),
          const YoutubeResponse(items: [], nextPageToken: null),
        );
        expect(
          mapper.mapPlaylistItemResponse(PlaylistItemListResponse(items: [])),
          const YoutubeResponse(items: [], nextPageToken: null),
        );

        final validResponse = PlaylistItemListResponse(
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
        );

        final expectedChannel = YoutubeResponse(
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
        );

        expect(mapper.mapPlaylistItemResponse(validResponse), expectedChannel);
      });
    });

    group('#mapSearchListResponse', () {
      test('should fail if response is invalid', () {
        final invalidResponses = [
          SearchListResponse(items: [SearchResult()]),
          SearchListResponse(items: [
            SearchResult(
              id: ResourceId(videoId: 'mock'),
            ),
          ]),
          SearchListResponse(items: [
            SearchResult(
              id: ResourceId(videoId: 'mock'),
              snippet: SearchResultSnippet(title: 'title', description: 'desc'),
            ),
          ]),
        ];

        for (final response in invalidResponses) {
          expect(
            () => mapper.mapSearchListResponse(response),
            throwsException,
          );
        }
      });

      test('should parse valid response properly', () {
        expect(
          mapper.mapSearchListResponse(SearchListResponse()),
          const YoutubeResponse(items: [], nextPageToken: null),
        );
        expect(
          mapper.mapSearchListResponse(SearchListResponse(items: [])),
          const YoutubeResponse(items: [], nextPageToken: null),
        );

        final validResponse = SearchListResponse(
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
        );

        final expectedChannel = YoutubeResponse(
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
        );

        expect(mapper.mapSearchListResponse(validResponse), expectedChannel);
      });
    });
  });
}
