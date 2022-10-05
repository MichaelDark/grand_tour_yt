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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YoutubeVideo &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.thumbnail == thumbnail &&
        other.publishedAt == publishedAt &&
        other.duration == duration &&
        other.licensedContent == licensedContent &&
        other.commentCount == commentCount &&
        other.likeCount == likeCount &&
        other.viewCount == viewCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        thumbnail.hashCode ^
        publishedAt.hashCode ^
        duration.hashCode ^
        licensedContent.hashCode ^
        commentCount.hashCode ^
        likeCount.hashCode ^
        viewCount.hashCode;
  }
}
