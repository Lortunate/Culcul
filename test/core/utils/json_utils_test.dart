import 'package:culcul/core/utils/json_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JsonUtils', () {
    group('parseInt', () {
      test('returns null for null input', () {
        expect(JsonUtils.parseInt(null), isNull);
      });

      test('returns int directly when input is int', () {
        expect(JsonUtils.parseInt(42), 42);
      });

      test('parses valid int string', () {
        expect(JsonUtils.parseInt('123'), 123);
      });

      test('parses negative int string', () {
        expect(JsonUtils.parseInt('-5'), -5);
      });

      test('returns null for non-numeric string', () {
        expect(JsonUtils.parseInt('abc'), isNull);
      });

      test('returns null for empty string', () {
        expect(JsonUtils.parseInt(''), isNull);
      });

      test('returns null for double input', () {
        expect(JsonUtils.parseInt(3.14), isNull);
      });

      test('returns null for bool input', () {
        expect(JsonUtils.parseInt(true), isNull);
      });

      test('returns null for list input', () {
        expect(JsonUtils.parseInt([1, 2]), isNull);
      });
    });

    group('parseIntWithDefault', () {
      test('returns parsed int when valid', () {
        expect(JsonUtils.parseIntWithDefault('42'), 42);
      });

      test('returns int directly when input is int', () {
        expect(JsonUtils.parseIntWithDefault(7), 7);
      });

      test('returns default (0) for null input', () {
        expect(JsonUtils.parseIntWithDefault(null), 0);
      });

      test('returns default (0) for non-numeric string', () {
        expect(JsonUtils.parseIntWithDefault('abc'), 0);
      });

      test('returns custom default for null input', () {
        expect(JsonUtils.parseIntWithDefault(null, -1), -1);
      });

      test('returns custom default for non-numeric string', () {
        expect(JsonUtils.parseIntWithDefault('abc', 99), 99);
      });
    });

    group('parseStringWithDefault', () {
      test('returns string directly when input is String', () {
        expect(JsonUtils.parseStringWithDefault('hello'), 'hello');
      });

      test('returns empty string default for null input', () {
        expect(JsonUtils.parseStringWithDefault(null), '');
      });

      test('returns custom default for null input', () {
        expect(JsonUtils.parseStringWithDefault(null, 'fallback'), 'fallback');
      });

      test('converts int to string', () {
        expect(JsonUtils.parseStringWithDefault(42), '42');
      });

      test('converts double to string', () {
        expect(JsonUtils.parseStringWithDefault(3.14), '3.14');
      });

      test('converts bool to string', () {
        expect(JsonUtils.parseStringWithDefault(true), 'true');
      });
    });

    group('parseStringListWithDefault', () {
      test('returns empty list for null input', () {
        expect(JsonUtils.parseStringListWithDefault(null), isEmpty);
      });

      test('returns empty list for non-list input', () {
        expect(JsonUtils.parseStringListWithDefault('not a list'), isEmpty);
      });

      test('parses List<String> directly', () {
        expect(
          JsonUtils.parseStringListWithDefault(['a', 'b', 'c']),
          ['a', 'b', 'c'],
        );
      });

      test('converts mixed list to List<String>', () {
        expect(
          JsonUtils.parseStringListWithDefault(['hello', 42, true]),
          ['hello', '42', 'true'],
        );
      });

      test('handles empty list input', () {
        expect(JsonUtils.parseStringListWithDefault([]), isEmpty);
      });
    });
  });
}
