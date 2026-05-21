import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:culcul/i18n/strings.g.dart';

class LiveDanmakuEventParser {
  const LiveDanmakuEventParser();

  LiveDanmakuItem? parse(Map<String, dynamic> event) {
    final cmd = event['cmd'] as String?;
    if (cmd == null || cmd.isEmpty) return null;

    if (cmd.startsWith('DANMU_MSG')) {
      return _parseDanmu(event);
    }
    if (cmd == 'INTERACT_WORD') {
      return _parseInteractWord(event);
    }
    if (cmd == 'NOTICE_MSG') {
      return _parseNotice(event);
    }
    if (cmd == 'SEND_GIFT') {
      return _parseGift(event);
    }

    return null;
  }

  LiveDanmakuItem? _parseDanmu(Map<String, dynamic> event) {
    try {
      final info = event['info'];
      if (info is! List || info.length < 3) return null;
      final user = info[2];
      if (user is! List || user.length < 2) return null;

      final medal = _parseMedalFromList(info.length > 3 ? info[3] : null);
      final userLevel = _parseUserLevelFromList(info.length > 4 ? info[4] : null);
      final title = _parseTitleFromList(info.length > 5 ? info[5] : null);

      return LiveDanmakuItem(
        text: info[1]?.toString() ?? '',
        nickname: user[1]?.toString() ?? '',
        uid: _asInt(user[0]),
        timeline: DateTime.now().toIso8601String(),
        isadmin: user.length > 2 ? _asInt(user[2]) : 0,
        vip: user.length > 3 ? _asInt(user[3]) : 0,
        svip: user.length > 4 ? _asInt(user[4]) : 0,
        medal: medal,
        title: title,
        userLevel: userLevel,
      );
    } catch (error, stackTrace) {
      DevLogger.log('live', 'danmaku.parse_failed', <String, Object?>{
        'cmd': 'DANMU_MSG',
        'error': error,
        'stack': stackTrace,
      });
      return null;
    }
  }

  LiveDanmakuItem? _parseInteractWord(Map<String, dynamic> event) {
    try {
      final data = event['data'];
      if (data is! Map<String, dynamic>) return null;
      final msgType = _asInt(data['msg_type']);

      var text = t.live.danmaku.enter_room;
      if (msgType == 2) text = t.live.danmaku.followed;
      if (msgType == 3) text = t.live.danmaku.shared;

      final fansMedal = data['fans_medal'];
      LiveDanmakuMedal? medal;
      if (fansMedal is Map<String, dynamic>) {
        medal = _parseMedalFromMap(fansMedal);
      }

      return LiveDanmakuItem(
        text: text,
        nickname: data['uname']?.toString() ?? '',
        uid: _asInt(data['uid']),
        dmType: 1,
        medal: medal,
      );
    } catch (error, stackTrace) {
      DevLogger.log('live', 'danmaku.parse_failed', <String, Object?>{
        'cmd': 'INTERACT_WORD',
        'error': error,
        'stack': stackTrace,
      });
      return null;
    }
  }

  LiveDanmakuItem? _parseNotice(Map<String, dynamic> event) {
    try {
      final msgSelf = event['msg_self']?.toString();
      final msgCommon = event['msg_common']?.toString();
      final message = (msgSelf != null && msgSelf.isNotEmpty) ? msgSelf : msgCommon;
      if (message == null || message.isEmpty) return null;

      return LiveDanmakuItem(
        text: message,
        nickname: t.live.danmaku.system_notice,
        uid: 0,
        dmType: 3,
      );
    } catch (error, stackTrace) {
      DevLogger.log('live', 'danmaku.parse_failed', <String, Object?>{
        'cmd': 'NOTICE_MSG',
        'error': error,
        'stack': stackTrace,
      });
      return null;
    }
  }

  LiveDanmakuItem? _parseGift(Map<String, dynamic> event) {
    try {
      final data = event['data'];
      if (data is! Map<String, dynamic>) return null;

      final giftName = data['giftName']?.toString() ?? '';
      final num = _asInt(data['num']);
      final medalInfo = data['medal_info'];
      LiveDanmakuMedal? medal;
      if (medalInfo is Map<String, dynamic>) {
        medal = _parseMedalFromMap(medalInfo);
      }

      return LiveDanmakuItem(
        text: t.live.danmaku.gift_feed(giftName: giftName, num: num.toString()),
        nickname: data['uname']?.toString() ?? '',
        uid: _asInt(data['uid']),
        dmType: 2,
        medal: medal,
      );
    } catch (error, stackTrace) {
      DevLogger.log('live', 'danmaku.parse_failed', <String, Object?>{
        'cmd': 'SEND_GIFT',
        'error': error,
        'stack': stackTrace,
      });
      return null;
    }
  }

  LiveDanmakuMedal? _parseMedalFromList(dynamic value) {
    if (value is! List || value.length < 2) return null;
    return LiveDanmakuMedal(
      level: _asInt(value[0]),
      name: value[1]?.toString() ?? '',
      anchorRoomId: value.length > 3 ? _asInt(value[3]) : 0,
      color: value.length > 4 ? _asInt(value[4]) : 0,
    );
  }

  LiveDanmakuMedal _parseMedalFromMap(Map<String, dynamic> value) {
    return LiveDanmakuMedal(
      level: _asInt(value['medal_level']),
      name: value['medal_name']?.toString() ?? '',
      anchorRoomId: _asInt(value['anchor_roomid']),
      color: _asInt(value['medal_color']),
    );
  }

  LiveDanmakuTitle? _parseTitleFromList(dynamic value) {
    if (value is! List || value.isEmpty) return null;
    return LiveDanmakuTitle(
      title: value.first?.toString() ?? '',
      skin: value.length > 1 ? value[1]?.toString() ?? '' : '',
    );
  }

  LiveDanmakuUserLevel? _parseUserLevelFromList(dynamic value) {
    if (value is! List || value.isEmpty) return null;
    return LiveDanmakuUserLevel(
      level: _asInt(value[0]),
      rank: value.length > 1 ? _asInt(value[1]) : 0,
    );
  }

  int _asInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
