import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/presentation/pages/comment_reply_page_commands.dart';
import 'package:culcul/shared/pagination/pagination_load_gate.dart';
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
  group('CommentReplyPageCommands', () {
    test('showReplySheet maps item ids into addReply arguments', () async {
      final calls = <(int oid, int root, int parent, String text)>[];
      Future<void> Function(String)? capturedOnSend;
      final commands = CommentReplyPageCommands(
        loadGate: PaginationLoadGate(),
        presentReplySheet: ({required comment, required onSend}) {
          capturedOnSend = onSend;
        },
        addReply: (oid, root, parent, text) async {
          calls.add((oid, root, parent, text));
        },
        hasMoreReplies: () => false,
        isLoadingMoreReplies: () => false,
        loadMoreRepliesFromController: () async {},
        currentReplyCount: () => 0,
      );

      commands.showReplySheet(_comment(oid: 100, rpid: 20, root: 0));
      expect(capturedOnSend, isNotNull);
      await capturedOnSend!('reply');

      expect(calls.single, (100, 20, 20, 'reply'));
    });

    test('loadMoreReplies delegates to paged load-more orchestration', () async {
      var hasMore = true;
      var loadMoreCount = 0;
      final commands = CommentReplyPageCommands(
        loadGate: PaginationLoadGate(),
        presentReplySheet: ({required comment, required onSend}) {},
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
  });
}
