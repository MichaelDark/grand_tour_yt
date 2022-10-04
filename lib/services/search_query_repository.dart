import '../models/db/search_query.dart';

abstract class SearchQueryRepository {
  Future<void> saveQuery(String query);

  List<SearchQuery> getCachedQueries();

  Future<void> clearCachedQueries();
}
