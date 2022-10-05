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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YoutubePlaylist &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        thumbnail.hashCode;
  }
}
