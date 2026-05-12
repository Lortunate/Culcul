import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/features/video/presentation/comments/comment_reply_page.dart';
import 'package:culcul/features/video/presentation/comments/comment_reply_state.dart';
import 'package:culcul/features/video/presentation/comments/comment_reply_view_model.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/core/data/pagination/paged_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      officialVerify: OfficialVerify(),
      vip: CommentVip(),
    ),
    content: const CommentContent(message: 'hello'),
  );
}

void main() {
  testWidgets('CommentReplyPage routes reply-sheet submit through CommentReplyCommands', (
    tester,
  ) async {
    final comment = _comment(oid: 100, rpid: 20, root: 0);
    _TestCommentReplyController.reset(
      CommentReplyState(
        rootComment: comment,
        paging: const PagedListState<CommentItem>(
          items: <CommentItem>[],
          isInitialLoading: false,
          hasMore: false,
        ),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          commentReplyControllerProvider(
            100,
            20,
          ).overrideWith(_TestCommentReplyController.new),
        ],
        child: TranslationProvider(
          child: MaterialApp(
            home: CommentReplyPage(oid: 100, rootId: 20, comment: comment),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.chat_bubble_outline_rounded).first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'reply');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    expect(_TestCommentReplyController.addReplyCalls.single, (100, 20, 20, 'reply'));
  });
}

class _TestCommentReplyController extends CommentReplyController {
  static CommentReplyState _initialState = const CommentReplyState();
  static final List<(int oid, int root, int parent, String text)> addReplyCalls =
      <(int oid, int root, int parent, String text)>[];

  static void reset(CommentReplyState initialState) {
    _initialState = initialState;
    addReplyCalls.clear();
  }

  @override
  CommentReplyState build(int oid, int rootId) => _initialState;

  @override
  Future<void> addReply(int oid, int root, int parent, String message) async {
    addReplyCalls.add((oid, root, parent, message));
  }

  @override
  Future<void> refresh() async {}

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> toggleCommentLike(int oid, int rpid, bool isLiked) async {}

  @override
  Future<void> toggleCommentDislike(int oid, int rpid) async {}
}
