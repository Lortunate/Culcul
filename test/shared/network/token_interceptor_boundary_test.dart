import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('token interceptor does not import auth feature directly', () {
    final source = File(
      'lib/core/network/interceptors/token_interceptor.dart',
    ).readAsStringSync();

    expect(source, isNot(contains('features/auth')));
    expect(source, contains('session_cookie_refresher.dart'));
  });
}
