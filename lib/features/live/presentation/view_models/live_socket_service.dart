import 'dart:async';
import 'dart:convert';

import 'package:culcul/core/perf/dev_logger.dart';
import 'package:culcul/core/runtime/runtime_performance_policy.dart';
import 'package:culcul/features/live/application/models/live_danmu_info_model.dart';
import 'package:culcul/features/live/application/models/live_history_danmaku_model.dart';
import 'package:culcul/features/live/presentation/view_models/live_danmaku_event_parser.dart';
import 'package:culcul/features/live/presentation/view_models/live_socket_packet_codec.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LiveSocketService {
  LiveSocketService({LiveDanmakuEventParser? eventParser})
    : _eventParser = eventParser ?? const LiveDanmakuEventParser();

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _channelSubscription;
  Timer? _heartbeatTimer;
  final StreamController<LiveDanmakuItem> _danmakuController =
      StreamController.broadcast();
  final LiveDanmakuEventParser _eventParser;
  LiveDanmuInfoModel? _lastInfo;
  int? _lastRoomId;
  bool _isSuspended = false;
  bool _isDisposed = false;

  Stream<LiveDanmakuItem> get danmakuStream => _danmakuController.stream;

  bool get isConnected => _channel != null;

  Future<void> connect({required LiveDanmuInfoModel info, required int roomId}) async {
    _lastInfo = info;
    _lastRoomId = roomId;
    if (_isSuspended || _isDisposed) {
      disconnect();
      return;
    }
    await _connectNow(info: info, roomId: roomId);
  }

  void applyRuntimePolicy(RuntimePerformancePolicy policy) {
    final shouldSuspend = policy.timerBehavior == RuntimeTimerBehavior.suspended;
    if (_isSuspended == shouldSuspend) return;

    _isSuspended = shouldSuspend;
    if (shouldSuspend) {
      disconnect();
      return;
    }

    final info = _lastInfo;
    final roomId = _lastRoomId;
    if (info != null && roomId != null && !isConnected) {
      unawaited(_connectNow(info: info, roomId: roomId));
    }
  }

  Future<void> _connectNow({
    required LiveDanmuInfoModel info,
    required int roomId,
  }) async {
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

      _channelSubscription = _channel!.stream.listen(
        _handleMessage,
        onError: (Object error, StackTrace stackTrace) => DevLogger.log(
          'live',
          'socket.error',
          <String, Object?>{'error': error, 'stack': stackTrace},
        ),
        onDone: () {
          _heartbeatTimer?.cancel();
          _channel = null;
          DevLogger.log('live', 'socket.closed');
        },
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
    } catch (error, stackTrace) {
      DevLogger.log('live', 'socket.connect_failed', <String, Object?>{
        'error': error,
        'stack': stackTrace,
      });
    }
  }

  void disconnect() {
    _heartbeatTimer?.cancel();
    _channelSubscription?.cancel();
    _channelSubscription = null;
    _channel?.sink.close();
    _channel = null;
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    if (_isSuspended) return;
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      // Heartbeat packet: empty body, op 2
      _sendPacket(operation: 2, body: []);
    });
  }

  void _sendPacket({required int operation, required List<int> body}) {
    if (_isSuspended || _channel == null) return;

    _channel!.sink.add(LiveSocketPacketCodec.encode(operation: operation, body: body));
  }

  void _handleMessage(dynamic message) {
    if (message is! List<int>) return;

    for (final packet in LiveSocketPacketCodec.decode(message)) {
      switch (packet.operation) {
        case 5: // Notification
          if (packet.protocolVersion == 2) {
            // Zlib compressed
            unawaited(_handleCompressedNotifications(packet.body));
          } else if (packet.protocolVersion == 0) {
            // JSON
            try {
              final jsonStr = utf8.decode(packet.body);
              // Intentionally synchronous: live danmaku messages arrive at
              // high throughput. Using compute() per-message would add
              // isolate spawn overhead exceeding the decode cost itself.
              final json = jsonDecode(jsonStr) as Map<String, dynamic>;
              _parseNotification(json);
            } catch (error, stackTrace) {
              DevLogger.log('live', 'socket.notification_parse_failed', <String, Object?>{
                'error': error,
                'stack': stackTrace,
              });
            }
          } else if (packet.protocolVersion == 3) {
            // Brotli compressed - not supported natively in standard dart:io without plugins usually,
            // but let's assume zlib is used mostly for protover 2.
            // If protover 3 is used, we might need 'brotli' package or skip.
            // Bilibili usually negotiates protover. We sent 2 in auth.
            DevLogger.log('live', 'socket.brotli_unsupported');
          }
        case 8: // Auth Reply
          DevLogger.log('live', 'socket.authenticated');
        case 3: // Heartbeat Reply
      }
    }
  }

  Future<void> _handleCompressedNotifications(List<int> compressedBody) async {
    try {
      final events = await LiveSocketPacketCodec.decodeCompressedNotificationEvents(
        compressedBody,
      );
      if (_isDisposed) {
        return;
      }
      for (final event in events) {
        _parseNotification(event);
      }
    } catch (error, stackTrace) {
      DevLogger.log('live', 'socket.compressed_parse_failed', <String, Object?>{
        'error': error,
        'stack': stackTrace,
      });
    }
  }

  void _parseNotification(Map<String, dynamic> json) {
    if (_isDisposed || _danmakuController.isClosed) {
      return;
    }
    final item = _eventParser.parse(json);
    if (item != null) {
      _danmakuController.add(item);
    }
  }

  void dispose() {
    _isDisposed = true;
    disconnect();
    _danmakuController.close();
  }
}
