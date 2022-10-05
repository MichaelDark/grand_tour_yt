import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../models/db/search_query.dart';
import '../search_query_repository.dart';

@preResolve
@Singleton(as: SearchQueryRepository)
class HiveSearchQueryRepository implements SearchQueryRepository {
  @factoryMethod
  static Future<HiveSearchQueryRepository> create(Logger logger) async {
    var box = await Hive.openBox<DateTime>('searchQueriesBox');
    return HiveSearchQueryRepository._(logger, box);
  }

  final Logger _logger;
  final Box<DateTime> _searchQueriesBox;

  const HiveSearchQueryRepository._(this._logger, this._searchQueriesBox);

  @override
  Future<void> saveQuery(String query, DateTime searchTime) async {
    try {
      await _searchQueriesBox.put(query, searchTime);
    } catch (e, s) {
      _logger.e('Error saving search query "$query"', e, s);
      rethrow;
    }
  }

  @override
  List<SearchQuery> getCachedQueries() {
    try {
      final keys = _searchQueriesBox.keys;
      return keys
          .whereType<String>()
          .map((key) => SearchQuery(_searchQueriesBox.get(key)!, key))
          .toList();
    } catch (e, s) {
      _logger.e('Error getting saved search queries', e, s);
      rethrow;
    }
  }

  @override
  Future<void> clearCachedQueries() async {
    try {
      await _searchQueriesBox.clear();
    } catch (e, s) {
      _logger.e('Error clearing saved search queries', e, s);
      rethrow;
    }
  }
}
