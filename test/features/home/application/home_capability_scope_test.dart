import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'home uses feature scope and dedicated feed view models instead of a facade entry',
    () async {
      final featureScope = await File(
        'lib/features/home/feature_scope.dart',
      ).readAsString();
      final recommendViewModel = await File(
        'lib/features/home/presentation/view_models/home_recommend_view_model.dart',
      ).readAsString();
      final popularViewModel = await File(
        'lib/features/home/presentation/view_models/home_popular_view_model.dart',
      ).readAsString();
      final weeklyViewModel = await File(
        'lib/features/home/presentation/view_models/weekly_view_model.dart',
      ).readAsString();
      final removedFacadeFile = File('lib/features/home/application/home_facade.dart');

      expect(featureScope, isNot(contains('homeFacadeEntryProvider')));
      expect(featureScope, contains('homeFeedDataSourceProvider'));
      expect(
        recommendViewModel,
        contains("import 'package:culcul/features/home/feature_scope.dart';"),
      );
      expect(
        popularViewModel,
        contains("import 'package:culcul/features/home/feature_scope.dart';"),
      );
      expect(
        weeklyViewModel,
        contains("import 'package:culcul/features/home/feature_scope.dart';"),
      );
      expect(removedFacadeFile.existsSync(), isFalse);
    },
  );
}
