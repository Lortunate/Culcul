import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:culcul/features/live/domain/entities/live_entities.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LiveSocketService {
  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  final StreamController<LiveDanmakuItem> _danmakuController =
      StreamController.broadcast();

  Stream<LiveDanmakuItem> get danmakuStream => _danmakuController.stream;

  bool get isConnected => _channel != null;

  Future<void> connect({required LiveDanmuInfoModel info, required int roomId}) async {
    disconnect();

    try {
      final host = info.hostList.firstWhere(
        (h) => h.wssPort != 0,
        orElse: () => info.hostList.first,
      );
      final port = host.wssPort != 0 ? host.wssPort : host.wsPort;
      final scheme = host.wssPort != 0 ? 'wss' : 'ws';
      final uri = Uri.parse('$scheme://${host.host}:$port/sub');

      _channel = IOWebSocketChannel.connect(
        uri,
        headers: {'User-Agent': 'Mozilla/5.0'},
        pingInterval: const Duration(seconds: 30),
      );

      _channel!.stream.listen(
        (message) => _handleMessage(message),
        onError: (error) => debugPrint('Live WebSocket Error: $error'),
        onDone: () => debugPrint('Live WebSocket Closed'),
      );

      // Send auth packet
      final authBody = jsonEncode({
        'uid': 0,
        'roomid': roomId,
        'protover': 2,
        'platform': 'web',
        'type': 2,
        'key': info.token,
      });
      _sendPacket(operation: 7, body: utf8.encode(authBody));

      // Start heartbeat
      _startHeartbeat();
    } catch (e) {
      debugPrint('Failed to connect to Live WebSocket: $e');
    }
  }

  void disconnect() {
    _heartbeatTimer?.cancel();
    _channel?.sink.close();
    _channel = null;
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      // Heartbeat packet: empty body, op 2
      _sendPacket(operation: 2, body: []);
    });
  }

  void _sendPacket({required int operation, required List<int> body}) {
    if (_channel == null) return;

    final header = ByteData(16);
    final packetLength = 16 + body.length;

    header.setUint32(0, packetLength); // Packet Length
    header.setUint16(4, 16); // Header Length
    header.setUint16(6, 1); // Protocol Version
    header.setUint32(8, operation); // Operation
    header.setUint32(12, 1); // Sequence

    final packet = Uint8List(packetLength);
    packet.setRange(0, 16, header.buffer.asUint8List());
    packet.setRange(16, packetLength, body);

    _channel!.sink.add(packet);
  }

  void _handleMessage(dynamic message) {
    if (message is! List<int>) return;

    final data = Uint8List.fromList(message);
    var offset = 0;

    while (offset < data.length) {
      if (offset + 16 > data.length) break;

      final header = ByteData.sublistView(data, offset, offset + 16);
      final packetLength = header.getUint32(0);
      final protocolVer = header.getUint16(6);
      final operation = header.getUint32(8);

      if (offset + packetLength > data.length) break;

      final body = data.sublist(offset + 16, offset + packetLength);

      switch (operation) {
        case 5: // Notification
          if (protocolVer == 2) {
            // Zlib compressed
            try {
              final uncompressed = zlib.decode(body);
              _handleMessage(uncompressed); // Recursive for uncompressed batch
            } catch (e) {
              debugPrint('Failed to decompress zlib body: $e');
            }
          } else if (protocolVer == 0) {
            // JSON
            try {
              final jsonStr = utf8.decode(body);
              final json = jsonDecode(jsonStr);
              _parseNotification(json);
            } catch (e) {
              debugPrint('Failed to parse notification JSON: $e');
            }
          } else if (protocolVer == 3) {
            // Brotli compressed - not supported natively in standard dart:io without plugins usually,
            // but let's assume zlib is used mostly for protover 2.
            // If protover 3 is used, we might need 'brotli' package or skip.
            // Bilibili usually negotiates protover. We sent 2 in auth.
            debugPrint('Brotli compression (ver 3) not supported yet');
          }
          break;
        case 8: // Auth Reply
          debugPrint('Live WebSocket Authenticated');
          break;
        case 3: // Heartbeat Reply
          // debugPrint('Heartbeat reply: ${ByteData.sublistView(body).getUint32(0)} popularity');
          break;
      }

      offset += packetLength;
    }
  }

  void _parseNotification(Map<String, dynamic> json) {
    final cmd = json['cmd'] as String?;
    if (cmd == null) return;

    if (cmd.startsWith('DANMU_MSG')) {
      final info = json['info'] as List;
      if (info.isNotEmpty) {
        final text = info[1] as String;
        final user = info[2] as List;
        final nickname = user[1] as String;
        final uid = user[0] as int;

        final isadmin = user.length > 2 ? (user[2] as int) : 0;
        final vip = user.length > 3 ? (user[3] as int) : 0;
        final svip = user.length > 4 ? (user[4] as int) : 0;

        List<dynamic> medal = [];
        if (info.length > 3 && info[3] != null) {
          medal = info[3] as List;
        }

        List<dynamic> userLevel = [];
        if (info.length > 4 && info[4] != null) {
          userLevel = info[4] as List;
        }

        final item = LiveDanmakuItem(
          text: text,
          nickname: nickname,
          uid: uid,
          timeline: DateTime.now().toString(),
          isadmin: isadmin,
          vip: vip,
          svip: svip,
          medal: medal,
          userLevel: userLevel,
        );
        _danmakuController.add(item);
      }
    } else if (cmd == 'INTERACT_WORD') {
      final data = json['data'] as Map<String, dynamic>;
      final uname = data['uname'] as String;
      final msgType = data['msg_type'] as int;

      String text = t.live.danmaku.enter_room;
      if (msgType == 2) text = t.live.danmaku.followed;
      if (msgType == 3) text = t.live.danmaku.shared;

      final item = LiveDanmakuItem(
        text: text,
        nickname: uname,
        uid: data['uid'] as int,
        dmType: 1, // Interact
        medal: data['fans_medal'] != null
            ? [
                data['fans_medal']['medal_level'],
                data['fans_medal']['medal_name'],
                '',
                data['fans_medal']['anchor_roomid'],
                data['fans_medal']['medal_color'] ?? 0,
              ]
            : [],
      );
      _danmakuController.add(item);
    } else if (cmd == 'NOTICE_MSG') {
      final msgSelf = json['msg_self'] as String?;
      final msgCommon = json['msg_common'] as String?;
      final msg = msgSelf ?? msgCommon;

      if (msg != null && msg.isNotEmpty) {
        final item = LiveDanmakuItem(
          text: msg,
          nickname: t.live.danmaku.system_notice,
          uid: 0,
          dmType: 3, // System Notice
        );
        _danmakuController.add(item);
      }
    } else if (cmd == 'SEND_GIFT') {
      final data = json['data'] as Map<String, dynamic>;
      final uname = data['uname'] as String;
      final giftName = data['giftName'] as String;
      final num = data['num'] as int;

      final item = LiveDanmakuItem(
        text: t.live.danmaku.gift_feed(giftName: giftName, num: num.toString()),
        nickname: uname,
        uid: data['uid'] as int,
        dmType: 2, // Gift
        medal: data['medal_info'] != null
            ? [
                data['medal_info']['medal_level'],
                data['medal_info']['medal_name'],
                '',
                data['medal_info']['anchor_roomid'],
                data['medal_info']['medal_color'] ?? 0,
              ]
            : [],
      );
      _danmakuController.add(item);
    }
    // Handle other cmds like SEND_GIFT, INTERACT_WORD (entry), etc. if needed
  }

  void dispose() {
    disconnect();
    _danmakuController.close();
  }
}
