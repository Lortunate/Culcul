import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/features/video/presentation/comments/video_comment_tree_update.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('updateCommentLikeState', () {
    test('updates a root comment like state', () {
      final comment = _comment(rpid: 1, like: 2);

      final updated = updateCommentLikeState([comment], 1, isLiked: true);

      expect(updated.single.like, 3);
      expect(updated.single.action, 1);
    });

    test('updates nested replies without replacing untouched roots', () {
      final untouched = _comment(rpid: 1);
      final reply = _comment(rpid: 3, like: 4);
      final root = _comment(rpid: 2, replies: [reply]);
      final comments = [untouched, root];

      final updated = updateCommentLikeState(comments, 3, isLiked: false);

      expect(updated, isNot(same(comments)));
      expect(identical(updated.first, untouched), isTrue);
      expect(updated.last.replies.single.like, 3);
      expect(updated.last.replies.single.action, 0);
    });

    test('returns the original list when no comment matches', () {
      final comments = [_comment(rpid: 1)];

      final updated = updateCommentLikeState(comments, 99, isLiked: true);

      expect(identical(updated, comments), isTrue);
    });

    test('does not decrement likes below zero', () {
      final comment = _comment(rpid: 1);

      final updated = updateCommentLikeState([comment], 1, isLiked: false);

      expect(updated.single.like, 0);
      expect(updated.single.action, 0);
    });
  });
}

CommentItem _comment({
  required int rpid,
  int like = 0,
  List<CommentItem> replies = const [],
}) {
  return CommentItem(
    rpid: rpid,
    oid: 100,
    type: 1,
    mid: 200,
    root: 0,
    parent: 0,
    ctime: 0,
    like: like,
    member: const CommentMember(
      mid: '200',
      uname: 'user',
      sex: '',
      sign: '',
      avatar: '',
      rank: '',
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
    content: const CommentContent(message: ''),
    replies: replies,
  );
}
