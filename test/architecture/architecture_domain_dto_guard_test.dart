import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

void main() {
  test('domain entities must not contain DTO or response-shaped code', () {
    final offenders = <String>[];
    final dtoPattern = RegExp(r'\b(fromJson|toJson|JsonKey|Response|Request|Dto|DTO)\b');

    for (final file in dartFiles('lib')) {
      final path = normalizePath(file.path);
      if (!RegExp(r'^lib/features/[^/]+/domain/entities/').hasMatch(path)) {
        continue;
      }
      if (path.endsWith('.freezed.dart') || path.endsWith('.g.dart')) {
        continue;
      }

      final matches = <String>[];
      for (final line in authoredDartCodeLines(file)) {
        final match = dtoPattern.firstMatch(line.text);
        if (match != null) {
          matches.add('${match.group(1)}@${line.lineNumber}');
        }
      }

      if (matches.isNotEmpty) {
        offenders.add('$path contains ${matches.join(', ')}');
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'DTO/response-shaped code is not allowed in domain entities:\n'
          '${offenders.join('\n')}',
    );
  });
}
