import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('legacy video more bottom sheet adapter is removed', () async {
    final file = File(
      'lib/features/home/presentation/widgets/video_more_bottom_sheet.dart',
    );

    expect(
      await file.exists(),
      isFalse,
      reason:
          'Task 4 moves watch-later and cover-download behavior into home call sites.',
    );
  });

  test('home video call sites wire shared video actions directly', () async {
    final popularCard = File(
      'lib/features/home/presentation/widgets/popular_video_card.dart',
    );
    final recommendView = File(
      'lib/features/home/presentation/widgets/recommend_view.dart',
    );

    final popularContent = await popularCard.readAsString();
    final recommendContent = await recommendView.readAsString();

    expect(
      popularContent.contains('video_more_bottom_sheet.dart'),
      isFalse,
      reason: 'PopularVideoCard should stop depending on the legacy home adapter.',
    );
    expect(
      popularContent.contains('showHomeVideoActionsSheet'),
      isTrue,
      reason: 'PopularVideoCard should open the shared UI-only action sheet directly.',
    );
    expect(
      recommendContent.contains('onLongPress:'),
      isTrue,
      reason: 'RecommendView should own the long-press action wiring for home videos.',
    );
    expect(
      recommendContent.contains('showHomeVideoActionsSheet'),
      isTrue,
      reason:
          'RecommendView should launch the shared video action sheet from the home call site.',
    );
  });
}
