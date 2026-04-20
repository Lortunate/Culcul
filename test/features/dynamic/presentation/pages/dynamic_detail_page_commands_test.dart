import 'package:culcul/features/dynamic/presentation/pages/dynamic_detail_page_commands.dart';
import 'package:culcul/shared/pagination/pagination_load_gate.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DynamicDetailPageCommands', () {
    test('submitComment trims text, submits, clears input, and unfocuses', () async {
      final submitted = <String>[];
      var unfocusCount = 0;
      final controller = TextEditingController(text: '  hello world  ');
      final commands = DynamicDetailPageCommands(
        loadGate: PaginationLoadGate(),
        commentController: controller,
        hasPost: () => true,
        addReplyFromCurrentPost: (text) async {
          submitted.add(text);
        },
        toggleLike: () async => null,
        loadDetail: () async {},
        refreshCommentsForLatestPost: () async {},
        hasMoreComments: () => false,
        isLoadingMoreComments: () => false,
        loadMoreCommentsForLatestPost: () async {},
        currentCommentCount: () => 0,
        showOperationFailed: (_) {},
        unfocus: () {
          unfocusCount++;
        },
      );

      commands.submitComment();

      expect(submitted, ['hello world']);
      expect(controller.text, isEmpty);
      expect(unfocusCount, 1);
    });

    test('handleLike forwards failure message to presenter', () async {
      final errors = <String>[];
      final commands = DynamicDetailPageCommands(
        loadGate: PaginationLoadGate(),
        commentController: TextEditingController(),
        hasPost: () => true,
        addReplyFromCurrentPost: (_) async {},
        toggleLike: () async => 'failed',
        loadDetail: () async {},
        refreshCommentsForLatestPost: () async {},
        hasMoreComments: () => false,
        isLoadingMoreComments: () => false,
        loadMoreCommentsForLatestPost: () async {},
        currentCommentCount: () => 0,
        showOperationFailed: errors.add,
        unfocus: () {},
      );

      await commands.handleLike();

      expect(errors, ['failed']);
    });

    test(
      'refreshDetailAndComments sequences detail refresh before comments refresh',
      () async {
        final order = <String>[];
        final commands = DynamicDetailPageCommands(
          loadGate: PaginationLoadGate(),
          commentController: TextEditingController(),
          hasPost: () => true,
          addReplyFromCurrentPost: (_) async {},
          toggleLike: () async => null,
          loadDetail: () async {
            order.add('detail');
          },
          refreshCommentsForLatestPost: () async {
            order.add('comments');
          },
          hasMoreComments: () => false,
          isLoadingMoreComments: () => false,
          loadMoreCommentsForLatestPost: () async {},
          currentCommentCount: () => 0,
          showOperationFailed: (_) {},
          unfocus: () {},
        );

        await commands.refreshDetailAndComments();

        expect(order, ['detail', 'comments']);
      },
    );

    test('loadMoreComments delegates to paged load-more orchestration', () async {
      var hasMore = true;
      var loadMoreCount = 0;
      final commands = DynamicDetailPageCommands(
        loadGate: PaginationLoadGate(),
        commentController: TextEditingController(),
        hasPost: () => true,
        addReplyFromCurrentPost: (_) async {},
        toggleLike: () async => null,
        loadDetail: () async {},
        refreshCommentsForLatestPost: () async {},
        hasMoreComments: () => hasMore,
        isLoadingMoreComments: () => false,
        loadMoreCommentsForLatestPost: () async {
          loadMoreCount++;
          hasMore = false;
        },
        currentCommentCount: () => 12,
        showOperationFailed: (_) {},
        unfocus: () {},
      );

      await commands.loadMoreComments();

      expect(loadMoreCount, 1);
    });
  });
}
