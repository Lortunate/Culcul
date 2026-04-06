import 'package:culcul/features/live/data/dtos/live_history_danmaku_model.dart' as dto;
import 'package:culcul/features/live/data/live_room_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LiveDanmakuItemMapper converts dynamic lists into strong types', () {
    final source = dto.LiveDanmakuItem(
      text: 'hello',
      nickname: 'alice',
      uid: 1,
      medal: [6, 'medal-name', '', 9527, 16711935],
      title: ['title-name', 'skin-a'],
      userLevel: [24, 9],
    );

    final result = source.toDomain();
    expect(result.medal, isNotNull);
    expect(result.medal!.level, 6);
    expect(result.medal!.name, 'medal-name');
    expect(result.medal!.anchorRoomId, 9527);
    expect(result.medal!.color, 16711935);

    expect(result.title, isNotNull);
    expect(result.title!.title, 'title-name');
    expect(result.title!.skin, 'skin-a');

    expect(result.userLevel, isNotNull);
    expect(result.userLevel!.level, 24);
    expect(result.userLevel!.rank, 9);
  });
}
