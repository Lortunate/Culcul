import 'package:culcul/features/dynamic/application/dynamic_detail_actions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DynamicDetailActions', () {
    test('rejects blank comment submissions', () async {
      final actions = DynamicDetailActions(
        toggleLike: () async => null,
        addReply: (_, _, _) async {},
      );

      final result = await actions.submitComment('   ');

      expect(result, isFalse);
    });

    test('trims comment text before delegating reply creation', () async {
      late int root;
      late int parent;
      late String submittedText;
      final actions = DynamicDetailActions(
        toggleLike: () async => null,
        addReply: (valueRoot, valueParent, text) async {
          root = valueRoot;
          parent = valueParent;
          submittedText = text;
        },
      );

      final result = await actions.submitComment('  hello world  ');

      expect(result, isTrue);
      expect(root, 0);
      expect(parent, 0);
      expect(submittedText, 'hello world');
    });

    test('delegates like handling', () async {
      final actions = DynamicDetailActions(
        toggleLike: () async => 'error',
        addReply: (_, _, _) async {},
      );

      final result = await actions.handleLike();

      expect(result, 'error');
    });
  });
}
