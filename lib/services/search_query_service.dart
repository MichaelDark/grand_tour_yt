import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@preResolve
@singleton
class SearchQueryService {
  @factoryMethod
  static Future<SearchQueryService> create() async {
    var box = await Hive.openBox<DateTime>('searchQueriesBox');
    return SearchQueryService._(box);
  }

  final Box<DateTime> _searchQueriesBox;

  const SearchQueryService._(this._searchQueriesBox);

  Future<void> saveQuery(String query) async {
    await _searchQueriesBox.put(query, DateTime.now());
  }

  List<MapEntry<String, DateTime>> getCachedQueries() {
    final keys = _searchQueriesBox.keys;
    return keys
        .whereType<String>()
        .map((key) => MapEntry(key, _searchQueriesBox.get(key)!))
        .toList();
  }

  Future<void> clearCachedQueries() async {
    await _searchQueriesBox.clear();
  }
}
