import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dynamic page top tabs exclude anime and media', () {
    final source = File(
      'lib/features/dynamic/presentation/pages/dynamic_page.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('t.moments.tabs.pgc')));
    expect(source, isNot(contains("DynamicListView(type: 'pgc')")));
  });
}
