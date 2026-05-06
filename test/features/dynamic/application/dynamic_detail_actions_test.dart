import 'package:culcul/features/dynamic/application/dynamic_detail_actions.dart';
import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DynamicDetailActions', () {
    test('rejects blank comment submissions', () async {
      final actions = DynamicDetailActions(
        toggleLike: () async => null,
        addReply: (_, _, _) async {},
        loadGate: PaginationLoadGate(),
        loadDetail: () async {},
        refreshComments: () async {},
        hasMoreComments: () => false,
        isLoadingMoreComments: () => false,
        loadMoreCommentsFromSource: () async {},
        currentCommentCount: () => 0,
      );

      final result = await actions.submitComment('   ');

      expect(result, isFalse);
    });

    test('trims comment text before delegating reply creation', () async {
      late int root;
      late int parent;
      late String submittedText;
      final actions = DynamicDetailActions(
        toggleLike: () async => null,
        addReply: (valueRoot, valueParent, text) async {
          root = valueRoot;
          parent = valueParent;
          submittedText = text;
        },
        loadGate: PaginationLoadGate(),
        loadDetail: () async {},
        refreshComments: () async {},
        hasMoreComments: () => false,
        isLoadingMoreComments: () => false,
        loadMoreCommentsFromSource: () async {},
        currentCommentCount: () => 0,
      );

      final result = await actions.submitComment('  hello world  ');

      expect(result, isTrue);
      expect(root, 0);
      expect(parent, 0);
      expect(submittedText, 'hello world');
    });

    test('delegates like handling', () async {
      final actions = DynamicDetailActions(
        toggleLike: () async => 'error',
        addReply: (_, _, _) async {},
        loadGate: PaginationLoadGate(),
        loadDetail: () async {},
        refreshComments: () async {},
        hasMoreComments: () => false,
        isLoadingMoreComments: () => false,
        loadMoreCommentsFromSource: () async {},
        currentCommentCount: () => 0,
      );

      final result = await actions.handleLike();

      expect(result, 'error');
    });

    test(
      'refreshDetailAndComments sequences detail refresh before comments refresh',
      () async {
        final order = <String>[];
        final actions = DynamicDetailActions(
          toggleLike: () async => null,
          addReply: (_, _, _) async {},
          loadGate: PaginationLoadGate(),
          loadDetail: () async {
            order.add('detail');
          },
          refreshComments: () async {
            order.add('comments');
          },
          hasMoreComments: () => false,
          isLoadingMoreComments: () => false,
          loadMoreCommentsFromSource: () async {},
          currentCommentCount: () => 0,
        );

        await actions.refreshDetailAndComments();

        expect(order, ['detail', 'comments']);
      },
    );

    test('loadMoreComments delegates to paged load-more orchestration', () async {
      var hasMore = true;
      var loadMoreCount = 0;
      final actions = DynamicDetailActions(
        toggleLike: () async => null,
        addReply: (_, _, _) async {},
        loadGate: PaginationLoadGate(),
        loadDetail: () async {},
        refreshComments: () async {},
        hasMoreComments: () => hasMore,
        isLoadingMoreComments: () => false,
        loadMoreCommentsFromSource: () async {
          loadMoreCount++;
          hasMore = false;
        },
        currentCommentCount: () => 12,
      );

      await actions.loadMoreComments();

      expect(loadMoreCount, 1);
    });
  });
}
