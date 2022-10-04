import '../models/resources/paginated_ui_resource.dart';
import '../models/resources/ui_resource.dart';
import '../models/youtube/youtube_channel.dart';
import '../models/youtube/youtube_playlist.dart';
import '../models/youtube/youtube_playlist_item.dart';
import '../models/youtube/youtube_video.dart';

abstract class ChannelViewModel {
  UiResource<YoutubeChannel> get channelResource;
  PaginatedUiResource<YoutubePlaylist> get playlistsResource;
}

abstract class PlaylistViewModel {
  PaginatedUiResource<YoutubePlaylistItem> get playlistItemsResource;
}

abstract class VideoViewModel {
  UiResource<YoutubeVideo> get videoResource;
}

abstract class VideoSearchViewModel {
  PaginatedUiResource<YoutubePlaylistItem> get searchResultResource;
}
