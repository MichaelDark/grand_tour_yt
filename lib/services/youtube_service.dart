import '../../models/youtube/youtube_channel.dart';
import '../../models/youtube/youtube_playlist.dart';
import '../../models/youtube/youtube_playlist_item.dart';
import '../../models/youtube/youtube_response.dart';
import '../../models/youtube/youtube_video.dart';

abstract class YoutubeService {
  Future<YoutubeChannel> fetchChannel(String channelId);

  Future<YoutubeVideo> fetchVideo(String id);

  Future<YoutubeResponse<YoutubePlaylist>> fetchPlaylistsPage(
    String channelId,
    String? pageToken,
  );

  Future<YoutubeResponse<YoutubePlaylistItem>> fetchPlaylistPage(
    String playlistId,
    String? pageToken,
  );

  Future<YoutubeResponse<YoutubePlaylistItem>> searchVideos(
    String channelId,
    String query,
    String? pageToken,
  );
}
