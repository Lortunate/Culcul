import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lib/shared/ directory is fully retired', () {
    final sharedDir = Directory('lib/shared');

    expect(
      sharedDir.existsSync(),
      isFalse,
      reason:
          'lib/shared/ was fully retired on 2026-05-06. All infrastructure '
          'now lives under lib/core/ and all UI primitives under lib/ui/. '
          'If you need to add shared code, place it in the correct home: '
          'lib/core/ for infrastructure, lib/ui/ for UI primitives.',
    );
  });
}
