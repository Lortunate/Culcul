import 'package:flutter_test/flutter_test.dart';
import 'package:culcul/features/dynamic/domain/entities/dynamic_publish_command.dart';

void main() {
  test('dynamic publish contract accepts a feature command object, not File', () {
    final command = PublishDynamicCommand(text: 'hello', media: []);
    expect(command.media, isEmpty);
  });
}
