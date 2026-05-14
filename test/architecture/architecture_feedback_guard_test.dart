import 'package:flutter_test/flutter_test.dart';

import 'architecture_guard_utils.dart';

void main() {
  test('feature code must not call ScaffoldMessenger directly', () {
    final offenders = <String>[];

    for (final file in sourceDartFiles('lib')) {
      final path = normalizePath(file.path);
      if (_isApprovedFeedbackImplementation(path)) {
        continue;
      }

      for (final line in authoredDartCodeLines(file)) {
        if (line.text.contains('ScaffoldMessenger.of(')) {
          offenders.add('${formatLocation(path, line.lineNumber)} ScaffoldMessenger.of(');
        }
      }
    }

    expect(
      offenders,
      isEmpty,
      reason:
          'ScaffoldMessenger.of( is allowed only in central core '
          'feedback/error implementations:\n${offenders.join('\n')}',
    );
  });
}

bool _isApprovedFeedbackImplementation(String path) {
  return const {'lib/core/feedback/app_feedback.dart'}.contains(path);
}
