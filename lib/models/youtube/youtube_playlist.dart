import 'youtube_thumbnail.dart';

class YoutubePlaylist {
  final String id;
  final String title;
  final String description;
  final YoutubeThumbnail thumbnail;

  const YoutubePlaylist({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
  });
}
