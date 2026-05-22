import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:culcul/features/live/presentation/view_models/live_socket_packet_codec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LiveSocketPacketCodec', () {
    test('encodes packets with bilibili live header fields', () {
      final packet = LiveSocketPacketCodec.encode(operation: 7, body: [1, 2, 3]);
      final header = ByteData.sublistView(packet, 0, 16);

      expect(header.getUint32(0), 19);
      expect(header.getUint16(4), 16);
      expect(header.getUint16(6), 1);
      expect(header.getUint32(8), 7);
      expect(header.getUint32(12), 1);
      expect(packet.sublist(16), [1, 2, 3]);
    });

    test('decodes batched packets and ignores trailing partial headers', () {
      final first = LiveSocketPacketCodec.encode(operation: 5, body: [1]);
      final second = LiveSocketPacketCodec.encode(operation: 8, body: [2, 3]);
      final batched = Uint8List.fromList([...first, ...second, 0, 1, 2]);

      final packets = LiveSocketPacketCodec.decode(batched);

      expect(packets, hasLength(2));
      expect(packets[0].operation, 5);
      expect(packets[0].protocolVersion, 1);
      expect(packets[0].body, [1]);
      expect(packets[1].operation, 8);
      expect(packets[1].body, [2, 3]);
    });

    test('decodes compressed batched notification payloads off the UI path', () async {
      final first = LiveSocketPacketCodec.encode(
        operation: 5,
        protocolVersion: 0,
        body: utf8.encode(jsonEncode({'cmd': 'DANMU_MSG', 'text': 'first'})),
      );
      final second = LiveSocketPacketCodec.encode(
        operation: 5,
        protocolVersion: 0,
        body: utf8.encode(jsonEncode({'cmd': 'INTERACT_WORD', 'text': 'second'})),
      );
      final compressedBody = zlib.encode([...first, ...second]);

      final events = await LiveSocketPacketCodec.decodeCompressedNotificationEvents(
        compressedBody,
        offloadThresholdBytes: 1,
      );

      expect(events, hasLength(2));
      expect(events[0]['cmd'], 'DANMU_MSG');
      expect(events[1]['cmd'], 'INTERACT_WORD');
    });
  });
}
