import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('private session list provider is kept alive between page visits', () {
    final source = File(
      'lib/features/notification/presentation/view_models/private_session_view_model.dart',
    ).readAsStringSync();

    expect(
      source,
      contains(RegExp(r'@Riverpod\(keepAlive: true\)\r?\nclass PrivateSessionList')),
    );
  });
}
