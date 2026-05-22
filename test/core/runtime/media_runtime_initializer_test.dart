import 'package:culcul/core/runtime/media_runtime_initializer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ensureInitialized initializes media runtime once', () {
    var calls = 0;
    final initializer = MediaRuntimeInitializer.testing(
      initializeMediaKit: () {
        calls += 1;
      },
    );

    initializer.ensureInitialized();
    initializer.ensureInitialized();

    expect(calls, 1);
  });
}
