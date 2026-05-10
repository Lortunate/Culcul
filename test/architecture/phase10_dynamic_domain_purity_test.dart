import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dynamic domain repository does not import dart:io', () async {
    final dynamicRepositoryPath = 'lib/features/dynamic/domain/repositories/dynamic_repository.dart';
    final source = await File(dynamicRepositoryPath).readAsString();
    expect(source, isNot(contains("import 'dart:io'")));
  });
}
