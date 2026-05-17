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
  });
}
