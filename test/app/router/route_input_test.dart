import 'package:culcul/features/notification/domain/entities/private_session.dart';
import 'package:culcul/features/notification/route_entry.dart';
import 'package:culcul/features/video/domain/entities/video_entities.dart';
import 'package:culcul/features/video/route_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('chat route input keeps semantic payload together', () {
    const input = ChatRouteInput(
      name: 'tester',
      sessionType: PrivateSessionType.group,
      avatarUrl: 'avatar',
    );

    expect(input.name, 'tester');
    expect(input.sessionType, PrivateSessionType.group);
    expect(input.avatarUrl, 'avatar');
  });

  test('comment reply route input keeps comment payload together', () {
    final input = CommentReplyRouteInput(comment: _buildComment(), upperMid: 99);

    expect(input.upperMid, 99);
    expect(input.comment.content.message, 'hello');
  });
}

CommentItem _buildComment() {
  return CommentItem(
    rpid: 1,
    oid: 2,
    type: 1,
    mid: 3,
    root: 0,
    parent: 0,
    ctime: 123,
    member: const CommentMember(
      mid: '3',
      uname: 'tester',
      sex: '保密',
      sign: '',
      avatar: 'avatar',
      rank: '10000',
      levelInfo: CommentLevelInfo(
        currentLevel: 6,
        currentMin: 0,
        currentExp: 1,
        nextExp: 2,
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
