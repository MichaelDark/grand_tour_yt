import 'youtube_thumbnail.dart';

class YoutubeVideo {
  final String id;
  final String title;
  final String description;
  final YoutubeThumbnail thumbnail;
  final DateTime publishedAt;
  final Duration duration;
  final bool licensedContent;
  final int commentCount;
  final int likeCount;
  final int viewCount;

  const YoutubeVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.publishedAt,
    required this.duration,
    required this.licensedContent,
    required this.commentCount,
    required this.likeCount,
    required this.viewCount,
  });
}
