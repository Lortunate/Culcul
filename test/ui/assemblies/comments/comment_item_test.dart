import 'package:culcul/core/contracts/comment_contract.dart';
import 'package:culcul/core/contracts/relation_user_contract.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/assemblies/comments/comment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('tapping the username opens the comment author profile', (tester) async {
    int? tappedMid;

    await tester.pumpWidget(
      _TestApp(
        child: CommentItemWidget(
          item: _commentItem(memberMid: '12345'),
          onTapUser: (mid) => tappedMid = mid,
        ),
      ),
    );

    await tester.tap(find.text('Alice'));

    expect(tappedMid, 12345);
  });

  testWidgets('tapping the avatar opens the comment author profile', (tester) async {
    int? tappedMid;

    await tester.pumpWidget(
      _TestApp(
        child: CommentItemWidget(
          item: _commentItem(memberMid: '12345'),
          onTapUser: (mid) => tappedMid = mid,
        ),
      ),
    );

    await tester.tap(find.bySemanticsLabel('Avatar'));

    expect(tappedMid, 12345);
  });
}

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: MaterialApp(
        home: Scaffold(body: child),
        locale: AppLocale.zh.flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
      ),
    );
  }
}

CommentItem _commentItem({required String memberMid}) {
  return CommentItem(
    rpid: 1,
    oid: 2,
    type: 1,
    mid: int.parse(memberMid),
    root: 0,
    parent: 0,
    ctime: 0,
    member: _commentMember(mid: memberMid),
    content: const CommentContent(message: 'hello'),
  );
}

CommentMember _commentMember({required String mid}) {
  return CommentMember(
    mid: mid,
    uname: 'Alice',
    sex: '',
    sign: '',
    avatar: '',
    rank: '',
    levelInfo: const CommentLevelInfo(
      currentLevel: 0,
      currentMin: 0,
      currentExp: 0,
      nextExp: 0,
    ),
    pendant: const CommentPendant(pid: 0, name: '', image: '', expire: 0),
    nameplate: const CommentNameplate(
      nid: 0,
      name: '',
      image: '',
      imageSmall: '',
      level: '',
      condition: '',
    ),
    officialVerify: const OfficialVerify(),
    vip: const CommentVip(),
  );
}
