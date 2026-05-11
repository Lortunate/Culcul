import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

void main() {
  test('video barrel exposes route and public capabilities without re-exporting broad presentation internals', () async {
    final file = File('lib/features/video/video.dart');
    final content = await file.readAsString();
    
    // It should not export presentation files directly, except maybe very specific things if absolutely necessary,
    // but ideally no presentation stuff directly. The task says:
    // expect(exports, isNot(anyElement(contains('/presentation/'))));
    
    // We'll parse the exports.
    final exportLines = content.split('\n').where((l) => l.startsWith('export '));
    for (final line in exportLines) {
      if (line.contains('/presentation/')) {
        fail('Found presentation export in video.dart: $line');
      }
    }
  });
}
