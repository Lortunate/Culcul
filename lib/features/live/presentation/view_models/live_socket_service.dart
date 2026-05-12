import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:culcul/features/live/domain/live_models.dart';
import 'package:culcul/features/live/domain/entities/live_history_danmaku_model.dart';
import 'package:culcul/features/live/presentation/view_models/live_danmaku_event_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LiveSocketService {
  LiveSocketService({LiveDanmakuEventParser? eventParser})
    : _eventParser = eventParser ?? const LiveDanmakuEventParser();

  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  final StreamController<LiveDanmakuItem> _danmakuController =
      StreamController.broadcast();
  final LiveDanmakuEventParser _eventParser;

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
              // Intentionally synchronous: live danmaku messages arrive at
              // high throughput. Using compute() per-message would add
              // isolate spawn overhead exceeding the decode cost itself.
              final json = jsonDecode(jsonStr) as Map<String, dynamic>;
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
    final item = _eventParser.parse(json);
    if (item != null) {
      _danmakuController.add(item);
    }
  }

  void dispose() {
    disconnect();
    _danmakuController.close();
  }
}
