import 'youtube_thumbnail.dart';

class YoutubeVideo {
  final String id;
  final String videoId;
  final String title;
  final String description;
  final YoutubeThumbnail thumbnail;

  const YoutubeVideo({
    required this.id,
    required this.videoId,
    required this.title,
    required this.description,
    required this.thumbnail,
  });
}
