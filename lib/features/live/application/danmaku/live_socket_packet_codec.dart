import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

class LiveSocketPacket {
  const LiveSocketPacket({
    required this.protocolVersion,
    required this.operation,
    required this.body,
  });

  final int protocolVersion;
  final int operation;
  final Uint8List body;
}

class LiveSocketPacketCodec {
  const LiveSocketPacketCodec._();

  static const int headerLength = 16;
  static const int protocolVersion = 1;
  static const int sequence = 1;
  static const int compressedOffloadThresholdBytes = 8 * 1024;

  static Uint8List encode({
    required int operation,
    required List<int> body,
    int protocolVersion = LiveSocketPacketCodec.protocolVersion,
  }) {
    final packetLength = headerLength + body.length;
    final header = ByteData(headerLength);

    header.setUint32(0, packetLength);
    header.setUint16(4, headerLength);
    header.setUint16(6, protocolVersion);
    header.setUint32(8, operation);
    header.setUint32(12, sequence);

    final packet = Uint8List(packetLength);
    packet.setRange(0, headerLength, header.buffer.asUint8List());
    packet.setRange(headerLength, packetLength, body);
    return packet;
  }

  static List<LiveSocketPacket> decode(List<int> message) {
    final data = Uint8List.fromList(message);
    final packets = <LiveSocketPacket>[];
    var offset = 0;

    while (offset < data.length) {
      if (offset + headerLength > data.length) break;

      final header = ByteData.sublistView(data, offset, offset + headerLength);
      final packetLength = header.getUint32(0);
      final protocolVersion = header.getUint16(6);
      final operation = header.getUint32(8);

      if (packetLength < headerLength || offset + packetLength > data.length) {
        break;
      }

      packets.add(
        LiveSocketPacket(
          protocolVersion: protocolVersion,
          operation: operation,
          body: data.sublist(offset + headerLength, offset + packetLength),
        ),
      );
      offset += packetLength;
    }

    return packets;
  }

  static Future<List<Map<String, dynamic>>> decodeCompressedNotificationEvents(
    List<int> compressedBody, {
    int offloadThresholdBytes = compressedOffloadThresholdBytes,
  }) {
    if (compressedBody.length >= offloadThresholdBytes) {
      return compute(_decodeCompressedNotificationEvents, compressedBody);
    }
    return Future.value(_decodeCompressedNotificationEvents(compressedBody));
  }
}

List<Map<String, dynamic>> _decodeCompressedNotificationEvents(List<int> compressedBody) {
  final uncompressed = zlib.decode(compressedBody);
  return _decodeNotificationEventsFromMessage(uncompressed);
}

List<Map<String, dynamic>> _decodeNotificationEventsFromMessage(List<int> message) {
  final events = <Map<String, dynamic>>[];
  for (final packet in LiveSocketPacketCodec.decode(message)) {
    if (packet.operation != 5) {
      continue;
    }

    if (packet.protocolVersion == 2) {
      events.addAll(_decodeCompressedNotificationEvents(packet.body));
      continue;
    }

    if (packet.protocolVersion != 0) {
      continue;
    }

    final decoded = jsonDecode(utf8.decode(packet.body));
    if (decoded is Map<String, dynamic>) {
      events.add(decoded);
    }
  }
  return events;
}
