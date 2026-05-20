import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('home feed paging itemCount reads the latest provider state', () {
    expect(
      File('lib/features/home/presentation/widgets/live_view.dart').readAsStringSync(),
      contains('itemCount: () => ref.read(liveRecommendProvider).value?.length ?? 0'),
    );
    expect(
      File('lib/features/home/presentation/widgets/live_view.dart').readAsStringSync(),
      contains('hasMoreAfterLoad: ({required currentCount, required previousCount}) =>'),
    );
    expect(
      File(
        'lib/features/home/presentation/widgets/recommend_view.dart',
      ).readAsStringSync(),
      contains('itemCount: () => ref.read(homeRecommendProvider).value?.length ?? 0'),
    );
    expect(
      File('lib/features/home/presentation/widgets/popular_view.dart').readAsStringSync(),
      contains('itemCount: () => ref.read(homePopularProvider).value?.length ?? 0'),
    );
  });
}
