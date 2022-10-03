import 'youtube_thumbnail.dart';

class YoutubeChannel {
  static const grandTourChannelId = 'UCZ1Sc5xjWpUnp_o_lUTkvgQ';

  final String id;
  final String title;
  final String description;
  final String uploadsPlaylistId;
  final YoutubeThumbnail thumbnail;

  const YoutubeChannel({
    required this.id,
    required this.title,
    required this.description,
    required this.uploadsPlaylistId,
    required this.thumbnail,
  });
}
