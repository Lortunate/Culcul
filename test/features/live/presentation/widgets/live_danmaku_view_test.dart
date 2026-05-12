import 'package:culcul/features/live/domain/entities/live_history_danmaku_model.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_gift_message.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_interact_message.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_normal_message.dart';
import 'package:culcul/features/live/presentation/widgets/danmaku/live_system_message.dart';
import 'package:culcul/features/live/presentation/widgets/live_danmaku_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('routes items to corresponding danmaku widgets by dmType', (tester) async {
    final history = <LiveDanmakuItem>[
      const LiveDanmakuItem(text: 'normal', nickname: 'u1', uid: 1, dmType: 0),
      const LiveDanmakuItem(text: 'gift', nickname: 'u2', uid: 2, dmType: 2),
      const LiveDanmakuItem(text: 'interact', nickname: 'u3', uid: 3, dmType: 1),
      const LiveDanmakuItem(text: 'system', nickname: 'sys', uid: 0, dmType: 3),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: LiveDanmakuView(history: history)),
      ),
    );

    expect(find.byType(LiveNormalMessage), findsOneWidget);
    expect(find.byType(LiveGiftMessage), findsOneWidget);
    expect(find.byType(LiveInteractMessage), findsOneWidget);
    expect(find.byType(LiveSystemMessage), findsOneWidget);
  });
}
