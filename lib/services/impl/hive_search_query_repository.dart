import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../models/db/search_query.dart';
import '../search_query_repository.dart';

@preResolve
@Singleton(as: SearchQueryRepository)
class HiveSearchQueryRepository implements SearchQueryRepository {
  @factoryMethod
  static Future<HiveSearchQueryRepository> create() async {
    var box = await Hive.openBox<DateTime>('searchQueriesBox');
    return HiveSearchQueryRepository._(box);
  }

  final Box<DateTime> _searchQueriesBox;

  const HiveSearchQueryRepository._(this._searchQueriesBox);

  @override
  Future<void> saveQuery(String query) async {
    await _searchQueriesBox.put(query, DateTime.now());
  }

  @override
  List<SearchQuery> getCachedQueries() {
    final keys = _searchQueriesBox.keys;
    return keys
        .whereType<String>()
        .map((key) => SearchQuery(_searchQueriesBox.get(key)!, key))
        .toList();
  }

  @override
  Future<void> clearCachedQueries() async {
    await _searchQueriesBox.clear();
  }
}
