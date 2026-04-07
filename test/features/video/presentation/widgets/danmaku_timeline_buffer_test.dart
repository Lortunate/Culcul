import 'package:culcul/features/video/presentation/widgets/layers/danmaku_layer.dart';
import 'package:culcul/ui/widgets/danmaku/ns_danmaku/models/danmaku_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DanmakuItem item(String text, int time) => DanmakuItem(text, time: time);

  test('DanmakuTimelineBuffer emits due items in chronological order', () {
    final buffer = DanmakuTimelineBuffer();

    buffer.appendItems(<DanmakuItem>[
      item('late', 3000),
      item('early', 1000),
      item('mid', 2000),
    ], 0);

    expect(buffer.collectDueItems(1500).map((e) => e.text).toList(), <String>['early']);
    expect(buffer.collectDueItems(2500).map((e) => e.text).toList(), <String>['mid']);
    expect(buffer.collectDueItems(4000).map((e) => e.text).toList(), <String>['late']);
  });

  test('DanmakuTimelineBuffer keeps sorted timeline when inserting older segment', () {
    final buffer = DanmakuTimelineBuffer();

    buffer.appendItems(<DanmakuItem>[item('b', 2000), item('d', 4000)], 0);
    buffer.appendItems(<DanmakuItem>[item('a', 1000), item('c', 3000)], 0);

    expect(buffer.collectDueItems(1500).map((e) => e.text).toList(), <String>['a']);
    expect(buffer.collectDueItems(2500).map((e) => e.text).toList(), <String>['b']);
    expect(buffer.collectDueItems(3500).map((e) => e.text).toList(), <String>['c']);
    expect(buffer.collectDueItems(4500).map((e) => e.text).toList(), <String>['d']);
  });

  test('DanmakuTimelineBuffer detects large jumps and can seek', () {
    final buffer = DanmakuTimelineBuffer();
    buffer.appendItems(<DanmakuItem>[item('a', 1000), item('b', 2000)], 0);

    buffer.updateLastPosition(1000);
    expect(buffer.hasLargeJump(2000), isFalse);
    expect(buffer.hasLargeJump(3200), isTrue);

    buffer.seek(1800);
    expect(buffer.collectDueItems(2500).map((e) => e.text).toList(), <String>['b']);
  });

  test('DanmakuTimelineBuffer merges unordered historical batch in one pass', () {
    final buffer = DanmakuTimelineBuffer();
    buffer.appendItems(<DanmakuItem>[
      item('c', 3000),
      item('e', 5000),
      item('g', 7000),
    ], 0);
    buffer.appendItems(<DanmakuItem>[
      item('f', 6000),
      item('a', 1000),
      item('d', 4000),
      item('b', 2000),
    ], 0);

    expect(buffer.collectDueItems(1500).map((e) => e.text).toList(), <String>['a']);
    expect(buffer.collectDueItems(2500).map((e) => e.text).toList(), <String>['b']);
    expect(buffer.collectDueItems(3500).map((e) => e.text).toList(), <String>['c']);
    expect(buffer.collectDueItems(4500).map((e) => e.text).toList(), <String>['d']);
    expect(buffer.collectDueItems(5500).map((e) => e.text).toList(), <String>['e']);
    expect(buffer.collectDueItems(6500).map((e) => e.text).toList(), <String>['f']);
    expect(buffer.collectDueItems(7500).map((e) => e.text).toList(), <String>['g']);
  });

  test('DanmakuTimelineBuffer skips expired items outside emit window', () {
    final buffer = DanmakuTimelineBuffer();
    buffer.appendItems(<DanmakuItem>[item('expired', 1000), item('nearby', 4500)], 0);

    expect(buffer.collectDueItems(5000).map((e) => e.text).toList(), <String>['nearby']);
  });
}
