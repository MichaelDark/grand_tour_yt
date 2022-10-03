class YoutubeResponse<T> {
  final List<T> items;
  final String? nextPageToken;

  const YoutubeResponse({
    required this.items,
    required this.nextPageToken,
  });
}
