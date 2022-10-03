import 'youtube_thumbnail.dart';

class YoutubePlaylistItem {
  final String id;
  final String videoId;
  final String title;
  final String description;
  final YoutubeThumbnail thumbnail;
  final DateTime? publishedAt;

  const YoutubePlaylistItem({
    required this.id,
    required this.videoId,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.publishedAt,
  });
}