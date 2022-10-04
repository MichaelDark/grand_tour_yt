class SearchQuery {
  final DateTime searchedAt;
  final String query;

  SearchQuery(this.searchedAt, this.query);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchQuery &&
        other.searchedAt == searchedAt &&
        other.query == query;
  }

  @override
  int get hashCode => searchedAt.hashCode ^ query.hashCode;
}
