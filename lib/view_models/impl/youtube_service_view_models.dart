import '../../models/resources/impl/paginated_youtube_ui_resource.dart';
import '../../models/resources/impl/ui_future_resource.dart';
import '../../models/resources/paginated_ui_resource.dart';
import '../../models/resources/ui_resource.dart';
import '../../models/youtube/youtube_channel.dart';
import '../../models/youtube/youtube_playlist.dart';
import '../../models/youtube/youtube_playlist_item.dart';
import '../../models/youtube/youtube_video.dart';
import '../../services/youtube_service.dart';
import '../view_model_models.dart';

class YoutubeServiceChannelViewModel implements ChannelViewModel {
  @override
  final UiResource<YoutubeChannel> channelResource;
  @override
  final PaginatedUiResource<YoutubePlaylist> playlistsResource;

  YoutubeServiceChannelViewModel(YoutubeService service, String channelId)
      : channelResource = UiFutureResource(
          () => service.fetchChannel(channelId),
        ),
        playlistsResource = PaginatedYoutubeUiResource(
          (pageToken) => service.fetchPlaylistsPage(channelId, pageToken),
        );
}

class YoutubeServicePlaylistViewModel implements PlaylistViewModel {
  @override
  final PaginatedUiResource<YoutubePlaylistItem> playlistItemsResource;

  YoutubeServicePlaylistViewModel(YoutubeService service, String playlistId)
      : playlistItemsResource = PaginatedYoutubeUiResource(
          (pageToken) => service.fetchPlaylistPage(playlistId, pageToken),
        );
}

class YoutubeServiceVideoViewModel implements VideoViewModel {
  @override
  final UiResource<YoutubeVideo> videoResource;

  YoutubeServiceVideoViewModel(YoutubeService service, String videoId)
      : videoResource = UiFutureResource(
          () => service.fetchVideo(videoId),
        );
}

class YoutubeServiceVideoSearchViewModel implements VideoSearchViewModel {
  @override
  final PaginatedUiResource<YoutubePlaylistItem> searchResultResource;

  YoutubeServiceVideoSearchViewModel(
      YoutubeService service, String channelId, String query)
      : searchResultResource = PaginatedYoutubeUiResource(
          (pageToken) => service.searchVideos(channelId, query, pageToken),
        );
}
