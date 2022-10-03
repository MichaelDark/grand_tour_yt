import 'youtube_thumbnail.dart';

class YoutubeChannel {
  static const grandTourChannelId = 'UCZ1Sc5xjWpUnp_o_lUTkvgQ';
  static const driveTribeChannelId = 'UChiwLDIBJrV5SxqdixMHmQA';
  static const whatsNextChannelId = 'UCLw8Z2SQXD_v07gei77mQiA';
  static const richardHammondChannelId = 'UCheylHaby1OjlvHZgqBlKZw';
  static const channels = [
    grandTourChannelId,
    driveTribeChannelId,
    whatsNextChannelId,
    richardHammondChannelId,
  ];

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
