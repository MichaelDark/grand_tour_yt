import 'package:googleapis/youtube/v3.dart'
    show
        ChannelListResponse,
        PlaylistItemListResponse,
        PlaylistListResponse,
        SearchListResponse,
        ThumbnailDetails,
        VideoListResponse;
import 'package:injectable/injectable.dart';
import 'package:iso_duration_parser/iso_duration_parser.dart';

import '../../models/youtube/youtube_channel.dart';
import '../../models/youtube/youtube_playlist.dart';
import '../../models/youtube/youtube_playlist_item.dart';
import '../../models/youtube/youtube_response.dart';
import '../../models/youtube/youtube_thumbnail.dart';
import '../../models/youtube/youtube_video.dart';

@lazySingleton
class GoogleApiYoutubeMapper {
  YoutubeChannel mapChannel(ChannelListResponse response) {
    try {
      final channel = response.items!.first;

      return YoutubeChannel(
        id: channel.id!,
        title: channel.snippet!.title!,
        description: channel.snippet!.description!,
        uploadsPlaylistId: channel.contentDetails!.relatedPlaylists!.uploads!,
        subscriberCount: channel.statistics!.subscriberCount!.tryParseInt(),
        videoCount: channel.statistics!.videoCount!.tryParseInt(),
        thumbnail: YoutubeThumbnail(
          imageUrl: channel.snippet!.thumbnails!.maybeImageUrl,
        ),
      );
    } catch (e, s) {
      throw Exception('Failed to parse channel: $e\n$s');
    }
  }

  YoutubeVideo mapVideo(VideoListResponse response) {
    try {
      final video = response.items!.first;

      return YoutubeVideo(
        id: video.id!,
        title: video.snippet!.title!,
        description: video.snippet!.description!,
        thumbnail: YoutubeThumbnail(
          imageUrl: video.snippet!.thumbnails!.maybeImageUrl,
        ),
        publishedAt: video.snippet!.publishedAt!,
        duration: video.contentDetails!.duration!.parseIso8061Duration(),
        licensedContent: video.contentDetails?.licensedContent ?? false,
        commentCount: int.parse(video.statistics!.commentCount!),
        likeCount: int.parse(video.statistics!.likeCount!),
        viewCount: int.parse(video.statistics!.viewCount!),
      );
    } catch (e, s) {
      throw Exception('Failed to parse video: $e\n$s');
    }
  }

  YoutubeResponse<YoutubePlaylist> mapPlaylistResponse(
    PlaylistListResponse response,
  ) {
    try {
      return YoutubeResponse(
        items: response.items
                ?.map(
                  (playlist) => YoutubePlaylist(
                    id: playlist.id!,
                    title: playlist.snippet!.title!,
                    description: playlist.snippet!.description!,
                    thumbnail: YoutubeThumbnail(
                      imageUrl: playlist.snippet!.thumbnails!.maybeImageUrl,
                    ),
                  ),
                )
                .toList() ??
            [],
        nextPageToken: response.nextPageToken,
      );
    } catch (e, s) {
      throw Exception('Failed to parse playlists: $e\n$s');
    }
  }

  YoutubeResponse<YoutubePlaylistItem> mapPlaylistItemResponse(
    PlaylistItemListResponse response,
  ) {
    try {
      return YoutubeResponse(
        items: response.items
                ?.map(
                  (playlistItem) => YoutubePlaylistItem(
                    id: playlistItem.id!,
                    videoId: playlistItem.contentDetails!.videoId!,
                    title: playlistItem.snippet!.title!,
                    description: playlistItem.snippet!.description!,
                    thumbnail: YoutubeThumbnail(
                      imageUrl: playlistItem.snippet!.thumbnails!.maybeImageUrl,
                    ),
                    publishedAt: playlistItem.contentDetails!.videoPublishedAt,
                  ),
                )
                .toList() ??
            [],
        nextPageToken: response.nextPageToken,
      );
    } catch (e, s) {
      throw Exception('Failed to parse playlist items: $e\n$s');
    }
  }

  YoutubeResponse<YoutubePlaylistItem> mapSearchListResponse(
    SearchListResponse response,
  ) {
    try {
      return YoutubeResponse(
        items: response.items
                ?.map(
                  (playlistItem) => YoutubePlaylistItem(
                    id: playlistItem.id!.videoId!,
                    videoId: playlistItem.id!.videoId!,
                    title: playlistItem.snippet!.title!,
                    description: playlistItem.snippet!.description!,
                    thumbnail: YoutubeThumbnail(
                      imageUrl: playlistItem.snippet!.thumbnails!.maybeImageUrl,
                    ),
                    publishedAt: playlistItem.snippet!.publishedAt,
                  ),
                )
                .toList() ??
            [],
        nextPageToken: response.nextPageToken,
      );
    } catch (e, s) {
      throw Exception('Failed to parse search result: $e\n$s');
    }
  }
}

extension on String? {
  int? tryParseInt() {
    final text = this;
    if (text == null) return null;
    return int.tryParse(text);
  }

  Duration parseIso8061Duration() {
    final isoDuration = IsoDuration.parse(this!);
    final DateTime dateTime = DateTime(2000, 1, 1);
    final duration = isoDuration.withDate(dateTime).difference(dateTime);
    return duration.abs();
  }
}

extension on ThumbnailDetails {
  String? get maybeImageUrl {
    final imageUrl = high?.url ??
        medium?.url ??
        standard?.url ??
        maxres?.url ??
        default_?.url;
    return imageUrl;
  }
}
