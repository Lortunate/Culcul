import 'package:culcul/features/live/presentation/view_models/live_danmaku_feed_view_model.dart';
import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

LiveDanmakuItem _item(int uid) {
  return LiveDanmakuItem(text: 'text-$uid', nickname: 'user-$uid', uid: uid);
}

void main() {
  test('enqueue uses 33ms micro-batch flush and updates once', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final provider = liveDanmakuFeedProvider(1);
    final notifier = container.read(liveDanmakuFeedControllerProvider(1).notifier);
    var updateCount = 0;
    final sub = container.listen<LiveDanmakuFeedState>(
      provider,
      (_, _) => updateCount++,
      fireImmediately: false,
    );
    addTearDown(sub.close);

    notifier.enqueue(_item(1));
    notifier.enqueue(_item(2));
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(container.read(provider).items, isEmpty);

    await Future<void>.delayed(const Duration(milliseconds: 40));
    final state = container.read(provider);
    expect(state.items.map((it) => it.uid), [2, 1]);
    expect(updateCount, 1);
  });

  test('capacity is capped to 300 and keeps newest-first order', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final provider = liveDanmakuFeedProvider(2);
    final keepAlive = container.listen<LiveDanmakuFeedState>(
      provider,
      (_, _) {},
      fireImmediately: true,
    );
    addTearDown(keepAlive.close);
    final notifier = container.read(liveDanmakuFeedControllerProvider(2).notifier);

    for (var i = 1; i <= 350; i++) {
      notifier.enqueue(_item(i));
    }
    await Future<void>.delayed(const Duration(milliseconds: 40));

    final state = container.read(provider);
    expect(state.items.length, 300);
    expect(state.items.first.uid, 350);
    expect(state.items.last.uid, 51);
  });

  test('seed then enqueue preserves timeline semantics', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final provider = liveDanmakuFeedProvider(3);
    final keepAlive = container.listen<LiveDanmakuFeedState>(
      provider,
      (_, _) {},
      fireImmediately: true,
    );
    addTearDown(keepAlive.close);
    final notifier = container.read(liveDanmakuFeedControllerProvider(3).notifier);

    notifier.seed([_item(3), _item(2), _item(1)]);
    notifier.enqueue(_item(4));
    await Future<void>.delayed(const Duration(milliseconds: 40));

    final state = container.read(provider);
    expect(state.items.map((it) => it.uid), [4, 3, 2, 1]);
  });
}
