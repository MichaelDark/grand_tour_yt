import 'youtube_thumbnail.dart';

class YoutubeChannel {
  final String id;
  final String title;
  final String description;
  final String uploadsPlaylistId;
  final int? subscriberCount;
  final int? videoCount;
  final YoutubeThumbnail thumbnail;

  const YoutubeChannel({
    required this.id,
    required this.title,
    required this.description,
    required this.uploadsPlaylistId,
    required this.subscriberCount,
    required this.videoCount,
    required this.thumbnail,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YoutubeChannel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.uploadsPlaylistId == uploadsPlaylistId &&
        other.subscriberCount == subscriberCount &&
        other.videoCount == videoCount &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        uploadsPlaylistId.hashCode ^
        subscriberCount.hashCode ^
        videoCount.hashCode ^
        thumbnail.hashCode;
  }
}
