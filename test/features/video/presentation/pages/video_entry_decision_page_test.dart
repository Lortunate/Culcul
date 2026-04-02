import 'package:culcul/features/video/application/video_entry_workflows.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:culcul/features/video/presentation/pages/video_entry_decision_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('renders vertical page when workflow resolves vertical', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          resolveVideoEntryLayoutWorkflowProvider.overrideWithValue(
            ResolveVideoEntryLayoutWorkflow(
              _FakeVideoRepository(
                dimension: const VideoDimension(width: 1080, height: 1920, rotate: 0),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          home: VideoEntryDecisionPage(
            bvid: 'BV1',
            normalPageBuilder: (_) => const Text('normal'),
            verticalPageBuilder: (_) => const Text('vertical'),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('vertical'), findsOneWidget);
    expect(find.text('normal'), findsNothing);
  });

  testWidgets('renders normal page when workflow resolves normal', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          resolveVideoEntryLayoutWorkflowProvider.overrideWithValue(
            ResolveVideoEntryLayoutWorkflow(
              _FakeVideoRepository(
                dimension: const VideoDimension(width: 1920, height: 1080, rotate: 0),
              ),
            ),
          ),
        ],
        child: MaterialApp(
          home: VideoEntryDecisionPage(
            bvid: 'BV1',
            normalPageBuilder: (_) => const Text('normal'),
            verticalPageBuilder: (_) => const Text('vertical'),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('normal'), findsOneWidget);
    expect(find.text('vertical'), findsNothing);
  });

  testWidgets('falls back to normal page when workflow catches repository failure', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          resolveVideoEntryLayoutWorkflowProvider.overrideWithValue(
            ResolveVideoEntryLayoutWorkflow(_FakeVideoRepository(shouldThrow: true)),
          ),
        ],
        child: MaterialApp(
          home: VideoEntryDecisionPage(
            bvid: 'BV1',
            normalPageBuilder: (_) => const Text('normal'),
            verticalPageBuilder: (_) => const Text('vertical'),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('normal'), findsOneWidget);
    expect(find.text('vertical'), findsNothing);
  });
}

class _FakeVideoRepository extends Fake implements VideoRepository {
  final VideoDimension? dimension;
  final bool shouldThrow;

  _FakeVideoRepository({this.dimension, this.shouldThrow = false});

  @override
  Future<VideoDimension?> fetchVideoEntryDimension(String bvid) async {
    if (shouldThrow) {
      throw Exception('fetch failed');
    }
    return dimension;
  }
}
