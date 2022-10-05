import 'package:flutter/foundation.dart';

class YoutubeResponse<T> {
  final List<T> items;
  final String? nextPageToken;

  const YoutubeResponse({
    required this.items,
    required this.nextPageToken,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YoutubeResponse<T> &&
        listEquals(other.items, items) &&
        other.nextPageToken == nextPageToken;
  }

  @override
  int get hashCode => items.hashCode ^ nextPageToken.hashCode;
}
