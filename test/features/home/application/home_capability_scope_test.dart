import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('home exposes dedicated feed capabilities instead of a facade entry wrapper', () async {
    final featureScope = await File(
      'lib/features/home/feature_scope.dart',
    ).readAsString();
    final capabilitySource = await File(
      'lib/features/home/application/home_facade.dart',
    ).readAsString();

    expect(featureScope, isNot(contains('homeFacadeEntryProvider')));
    expect(capabilitySource, isNot(contains('class HomeFacade')));
    expect(capabilitySource, contains('homeRecommendFeedCapability'));
    expect(capabilitySource, contains('homePopularFeedCapability'));
    expect(capabilitySource, contains('homeWeeklyFeedCapability'));
  });
}
