class YoutubeThumbnail {
  final String? imageUrl;

  const YoutubeThumbnail({
    required this.imageUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is YoutubeThumbnail && other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => imageUrl.hashCode;
}
