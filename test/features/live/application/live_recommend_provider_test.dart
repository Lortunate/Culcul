import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('live recommendations use one page-size source for request and paging', () {
    final providerSource = File(
      'lib/features/live/application/live_recommend_provider.dart',
    ).readAsStringSync();
    final repositorySource = File(
      'lib/features/live/data/live_repository_impl.dart',
    ).readAsStringSync();

    expect(providerSource, contains('static const _recommendPageSize = 12;'));
    expect(providerSource, contains('pageSize: _recommendPageSize'));
    expect(
      providerSource,
      contains('bool hasMoreAfterPage(List<LiveRoomSummary> items) =>'),
    );
    expect(providerSource, contains('items.length >= _recommendPageSize;'));
    expect(repositorySource, contains('required int pageSize'));
    expect(
      repositorySource,
      contains('() => _api.getRecommendList(page: page, pageSize: pageSize),'),
    );
    expect(repositorySource, isNot(contains('() => _api.getRecommendList(page: page),')));
  });
}
