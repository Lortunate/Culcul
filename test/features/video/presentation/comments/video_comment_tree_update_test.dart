import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/features/video/presentation/comments/video_comment_tree_update.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('updates nested reply like state without rebuilding unchanged comments', () {
    final reply = _comment(rpid: 2, like: 4);
    final parent = _comment(rpid: 1, replies: [reply]);
    final sibling = _comment(rpid: 3);
    final comments = [parent, sibling];

    final updated = updateCommentLikeState(comments, 2, isLiked: true);

    expect(updated, isNot(same(comments)));
    expect(identical(updated[1], sibling), isTrue);
    expect(updated[0].replies.single.like, 5);
    expect(updated[0].replies.single.action, 1);
  });

  test('returns original list when comment id is absent', () {
    final comments = [_comment(rpid: 1)];

    final updated = updateCommentLikeState(comments, 99, isLiked: true);

    expect(identical(updated, comments), isTrue);
  });
}

CommentItem _comment({
  required int rpid,
  int like = 0,
  int action = 0,
  List<CommentItem> replies = const [],
}) {
  return CommentItem(
    rpid: rpid,
    oid: 1,
    type: 1,
    mid: 1,
    root: 0,
    parent: 0,
    ctime: 1,
    like: like,
    action: action,
    member: _member(),
    content: const CommentContent(message: ''),
    replies: replies,
  );
}

CommentMember _member() {
  return const CommentMember(
    mid: '1',
    uname: '',
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
  );
}
