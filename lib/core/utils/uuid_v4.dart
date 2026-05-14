import 'dart:math';

/// Generates a UUID v4 string using cryptographically secure random bytes.
///
/// Returns an uppercase UUID in standard 8-4-4-4-12 format.
String generateUuidV4() {
  final random = Random.secure();
  final bytes = List<int>.generate(16, (_) => random.nextInt(256));

  // Set version 4 bits
  bytes[6] = (bytes[6] & 0x0f) | 0x40;
  // Set variant bits
  bytes[8] = (bytes[8] & 0x3f) | 0x80;

  String hex(int byte) => byte.toRadixString(16).padLeft(2, '0');

  final buffer = StringBuffer()
    ..write(hex(bytes[0]))
    ..write(hex(bytes[1]))
    ..write(hex(bytes[2]))
    ..write(hex(bytes[3]))
    ..write('-')
    ..write(hex(bytes[4]))
    ..write(hex(bytes[5]))
    ..write('-')
    ..write(hex(bytes[6]))
    ..write(hex(bytes[7]))
    ..write('-')
    ..write(hex(bytes[8]))
    ..write(hex(bytes[9]))
    ..write('-')
    ..write(hex(bytes[10]))
    ..write(hex(bytes[11]))
    ..write(hex(bytes[12]))
    ..write(hex(bytes[13]))
    ..write(hex(bytes[14]))
    ..write(hex(bytes[15]));

  return buffer.toString().toUpperCase();
}
