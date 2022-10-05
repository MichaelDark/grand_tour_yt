import 'package:flutter_test/flutter_test.dart';
import 'package:grandtouryt/models/db/search_query.dart';
import 'package:grandtouryt/services/impl/hive_search_query_repository.dart';
import 'package:grandtouryt/services/search_query_repository.dart';
import 'package:hive_test/hive_test.dart';

import 'utils/general_mocks.dart';

void main() {
  group('HiveSearchQueryRepository', () {
    setUp(() async {
      await setUpTestHive();
    });

    tearDown(() async {
      await tearDownTestHive();
    });

    test('should read/write/delete', () async {
      final SearchQueryRepository repository =
          await HiveSearchQueryRepository.create(MockLogger());

      expect(repository.getCachedQueries(), isEmpty);

      await repository.saveQuery('test query #1', DateTime(2000, 1, 1));
      await repository.saveQuery('test query #2', DateTime(2000, 1, 2));
      await repository.saveQuery('test query #3', DateTime(2000, 1, 3));
      await repository.saveQuery('test query #4', DateTime(2000, 1, 4));

      expect(
        repository.getCachedQueries(),
        equals([
          SearchQuery(DateTime(2000, 1, 1), 'test query #1'),
          SearchQuery(DateTime(2000, 1, 2), 'test query #2'),
          SearchQuery(DateTime(2000, 1, 3), 'test query #3'),
          SearchQuery(DateTime(2000, 1, 4), 'test query #4'),
        ]),
      );

      await repository.clearCachedQueries();

      expect(repository.getCachedQueries(), isEmpty);
    });
  });
}
