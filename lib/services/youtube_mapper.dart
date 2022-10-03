import 'package:googleapis/youtube/v3.dart'
    show
        ChannelListResponse,
        PlaylistItemListResponse,
        PlaylistListResponse,
        ThumbnailDetails;
import 'package:injectable/injectable.dart';

import '../models/youtube/youtube_channel.dart';
import '../models/youtube/youtube_playlist.dart';
import '../models/youtube/youtube_response.dart';
import '../models/youtube/youtube_thumbnail.dart';
import '../models/youtube/youtube_video.dart';

@lazySingleton
class YoutubeMapper {
  YoutubeChannel mapChannel(ChannelListResponse response) {
    final channel = response.items!.first;

    return YoutubeChannel(
      id: channel.id!,
      title: channel.snippet!.title!,
      description: channel.snippet!.description!,
      uploadsPlaylistId: channel.contentDetails!.relatedPlaylists!.uploads!,
      thumbnail: YoutubeThumbnail(
        imageUrl: channel.snippet!.thumbnails!.maybeImageUrl,
      ),
    );
  }

  YoutubeResponse<YoutubePlaylist> mapPlaylistResponse(
    PlaylistListResponse response,
  ) {
    return YoutubeResponse(
      items: response.items!
          .map(
            (element) => YoutubePlaylist(
              id: element.id!,
              title: element.snippet!.title!,
              description: element.snippet!.description!,
              thumbnail: YoutubeThumbnail(
                imageUrl: element.snippet!.thumbnails!.maybeImageUrl,
              ),
            ),
          )
          .toList(),
      nextPageToken: response.nextPageToken,
    );
  }

  YoutubeResponse<YoutubeVideo> mapPlaylistItemResponse(
    PlaylistItemListResponse response,
  ) {
    return YoutubeResponse(
      items: response.items!
          .map(
            (element) => YoutubeVideo(
              id: element.id!,
              title: element.snippet!.title!,
              description: element.snippet!.description!,
              thumbnail: YoutubeThumbnail(
                imageUrl: element.snippet!.thumbnails!.maybeImageUrl,
              ),
            ),
          )
          .toList(),
      nextPageToken: response.nextPageToken,
    );
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
