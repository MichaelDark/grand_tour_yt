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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YoutubePlaylistItem &&
        other.id == id &&
        other.videoId == videoId &&
        other.title == title &&
        other.description == description &&
        other.thumbnail == thumbnail &&
        other.publishedAt == publishedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        videoId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        thumbnail.hashCode ^
        publishedAt.hashCode;
  }
}
