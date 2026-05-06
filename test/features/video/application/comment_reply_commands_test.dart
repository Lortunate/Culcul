import 'dart:async';

import 'package:culcul/features/video/application/comment_reply_commands.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/core/pagination/pagination_load_gate.dart';
import 'package:flutter_test/flutter_test.dart';

CommentItem _comment({required int oid, required int rpid, required int root}) {
  return CommentItem(
    rpid: rpid,
    oid: oid,
    root: root,
    type: 1,
    mid: 1,
    parent: 0,
    ctime: 0,
    member: const CommentMember(
      mid: '1',
      uname: 'user',
      sex: '',
      sign: '',
      avatar: '',
      rank: '0',
      levelInfo: CommentLevelInfo(
        currentLevel: 0,
        currentMin: 0,
        currentExp: 0,
        nextExp: 0,
      ),
      pendant: CommentPendant(pid: 0, name: '', image: '', expire: 0),
      nameplate: CommentNameplate(
        nid: 0,
        name: '',
        image: '',
        imageSmall: '',
        level: '',
        condition: '',
      ),
      officialVerify: CommentOfficialVerify(),
      vip: CommentVip(),
    ),
    content: const CommentContent(message: 'hello'),
  );
}

void main() {
  group('CommentReplyCommands', () {
    test('submitReply maps item ids into addReply arguments', () async {
      final calls = <(int oid, int root, int parent, String text)>[];
      final commands = CommentReplyCommands(
        loadGate: PaginationLoadGate(),
        addReply: (oid, root, parent, text) async {
          calls.add((oid, root, parent, text));
        },
        hasMoreReplies: () => false,
        isLoadingMoreReplies: () => false,
        loadMoreRepliesFromController: () async {},
        currentReplyCount: () => 0,
      );

      await commands.submitReply(_comment(oid: 100, rpid: 20, root: 0), 'reply');

      expect(calls.single, (100, 20, 20, 'reply'));
    });

    test('loadMoreReplies delegates to paged load-more orchestration', () async {
      var hasMore = true;
      var loadMoreCount = 0;
      final commands = CommentReplyCommands(
        loadGate: PaginationLoadGate(),
        addReply: (oid, root, parent, text) async {},
        hasMoreReplies: () => hasMore,
        isLoadingMoreReplies: () => false,
        loadMoreRepliesFromController: () async {
          loadMoreCount++;
          hasMore = false;
        },
        currentReplyCount: () => 5,
      );

      await commands.loadMoreReplies();

      expect(loadMoreCount, 1);
    });

    test('loadMoreReplies skips orchestration when there are no more replies', () async {
      var loadMoreCount = 0;
      final commands = CommentReplyCommands(
        loadGate: PaginationLoadGate(),
        addReply: (oid, root, parent, text) async {},
        hasMoreReplies: () => false,
        isLoadingMoreReplies: () => false,
        loadMoreRepliesFromController: () async {
          loadMoreCount++;
        },
        currentReplyCount: () => 5,
      );

      await commands.loadMoreReplies();

      expect(loadMoreCount, 0);
    });

    test(
      'loadMoreReplies skips orchestration when a load is already in progress',
      () async {
        var loadMoreCount = 0;
        final commands = CommentReplyCommands(
          loadGate: PaginationLoadGate(),
          addReply: (oid, root, parent, text) async {},
          hasMoreReplies: () => true,
          isLoadingMoreReplies: () => true,
          loadMoreRepliesFromController: () async {
            loadMoreCount++;
          },
          currentReplyCount: () => 5,
        );

        await commands.loadMoreReplies();

        expect(loadMoreCount, 0);
      },
    );

    test(
      'loadMoreReplies suppresses repeated triggers while the gate is in flight',
      () async {
        final completer = Completer<void>();
        var loadMoreCount = 0;
        final commands = CommentReplyCommands(
          loadGate: PaginationLoadGate(),
          addReply: (oid, root, parent, text) async {},
          hasMoreReplies: () => true,
          isLoadingMoreReplies: () => false,
          loadMoreRepliesFromController: () {
            loadMoreCount++;
            return completer.future;
          },
          currentReplyCount: () => 5,
        );

        final first = commands.loadMoreReplies();
        final second = commands.loadMoreReplies();

        expect(loadMoreCount, 1);

        completer.complete();
        await Future.wait([first, second]);
      },
    );
  });
}
