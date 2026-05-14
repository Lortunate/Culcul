import 'dart:io';
import 'dart:typed_data';

import 'package:culcul/core/errors/app_error.dart';

class DanmakuMaskParser {
  final List<int> bytes;
  final int fps;

  DanmakuMaskParser(this.bytes, this.fps);

  Map<int, String> parse() {
    final data = ByteData.sublistView(Uint8List.fromList(bytes));
    int offset = 0;

    // Header "MASK"
    final header = String.fromCharCodes(bytes.sublist(0, 4));
    if (header != 'MASK') throw const AppError.data('Invalid mask file');
    offset += 4;

    // Version
    // ignore: unused_local_variable
    final version = data.getUint32(offset, Endian.big);
    offset += 4;

    // Unknown
    offset += 4;

    // Segment Count
    final segmentCount = data.getUint32(offset, Endian.big);
    offset += 4;

    final segments = <_MaskSegment>[];
    for (int i = 0; i < segmentCount; i++) {
      final time = data.getUint64(offset, Endian.big);
      offset += 8;
      final fileOffset = data.getUint64(offset, Endian.big);
      offset += 8;
      segments.add(_MaskSegment(time, fileOffset));
    }

    final result = <int, String>{}; // Time (ms) -> SVG Base64

    for (int i = 0; i < segmentCount; i++) {
      final segment = segments[i];
      final startOffset = segment.offset;
      final endOffset = (i == segmentCount - 1) ? bytes.length : segments[i + 1].offset;

      if (startOffset >= bytes.length || endOffset > bytes.length) continue;

      final compressedData = bytes.sublist(startOffset, endOffset);
      final decompressedData = gzip.decode(compressedData);

      // Skip first 16 bytes
      if (decompressedData.length < 16) continue;

      final content = decompressedData.sublist(16);
      final contentString = String.fromCharCodes(content);

      final frames = contentString.split('data:image/svg+xml;base64,');

      int currentTime = segment.time;
      final frameDuration = (1000 / fps).round();

      for (var j = 1; j < frames.length; j++) {
        final svgBase64 = frames[j];
        if (svgBase64.isEmpty) continue;

        result[currentTime] = svgBase64;
        currentTime += frameDuration;
      }
    }

    return result;
  }
}

class _MaskSegment {
  final int time;
  final int offset;
  _MaskSegment(this.time, this.offset);
}
