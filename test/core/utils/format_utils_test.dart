import 'package:culcul/core/utils/format_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FormatUtils', () {
    group('stripHtmlTags', () {
      test('removes HTML tags from string', () {
        expect(
          FormatUtils.stripHtmlTags('<p>Hello <b>world</b></p>'),
          'Hello world',
        );
      });

      test('returns string unchanged when no tags present', () {
        expect(FormatUtils.stripHtmlTags('plain text'), 'plain text');
      });

      test('returns empty string for empty input', () {
        expect(FormatUtils.stripHtmlTags(''), '');
      });

      test('removes self-closing tags', () {
        expect(FormatUtils.stripHtmlTags('line<br/>break'), 'linebreak');
      });

      test('removes tags with attributes', () {
        expect(
          FormatUtils.stripHtmlTags('<a href="https://example.com">link</a>'),
          'link',
        );
      });
    });

    group('formatImageUrl', () {
      test('prepends https to protocol-relative URL', () {
        expect(
          FormatUtils.formatImageUrl('//example.com/image.png'),
          'https://example.com/image.png',
        );
      });

      test('returns full URL unchanged', () {
        expect(
          FormatUtils.formatImageUrl('https://example.com/image.png'),
          'https://example.com/image.png',
        );
      });

      test('returns empty string for null input', () {
        expect(FormatUtils.formatImageUrl(null), '');
      });

      test('returns empty string for empty input', () {
        expect(FormatUtils.formatImageUrl(''), '');
      });
    });

    group('formatDuration', () {
      test('formats seconds only', () {
        expect(FormatUtils.formatDuration(45), '00:45');
      });

      test('formats minutes and seconds', () {
        expect(FormatUtils.formatDuration(125), '02:05');
      });

      test('formats hours, minutes and seconds', () {
        expect(FormatUtils.formatDuration(3661), '1:01:01');
      });

      test('formats zero seconds', () {
        expect(FormatUtils.formatDuration(0), '00:00');
      });

      test('pads single-digit minutes and seconds', () {
        expect(FormatUtils.formatDuration(65), '01:05');
      });
    });

    group('parseDurationString', () {
      test('parses MM:SS format', () {
        expect(FormatUtils.parseDurationString('2:05'), 125);
      });

      test('parses HH:MM:SS format', () {
        expect(FormatUtils.parseDurationString('1:01:01'), 3661);
      });

      test('returns 0 for null input', () {
        expect(FormatUtils.parseDurationString(null), 0);
      });

      test('returns 0 for empty string', () {
        expect(FormatUtils.parseDurationString(''), 0);
      });

      test('returns 0 for invalid format', () {
        expect(FormatUtils.parseDurationString('abc'), 0);
      });

      test('returns 0 for invalid parts', () {
        expect(FormatUtils.parseDurationString('ab:cd'), 0);
      });
    });

    group('formatFileSize', () {
      test('formats bytes', () {
        expect(FormatUtils.formatFileSize(512), '512B');
      });

      test('formats kilobytes', () {
        expect(FormatUtils.formatFileSize(1536), '1.5KB');
      });

      test('formats megabytes', () {
        expect(FormatUtils.formatFileSize(1048576), '1.0MB');
      });

      test('formats gigabytes', () {
        expect(FormatUtils.formatFileSize(1073741824), '1.0GB');
      });

      test('formats zero bytes', () {
        expect(FormatUtils.formatFileSize(0), '0B');
      });
    });

    group('capitalize', () {
      test('capitalizes lowercase string', () {
        expect(FormatUtils.capitalize('hello'), 'Hello');
      });

      test('lowercases remaining characters', () {
        expect(FormatUtils.capitalize('hELLO'), 'Hello');
      });

      test('returns empty string for empty input', () {
        expect(FormatUtils.capitalize(''), '');
      });

      test('handles single character', () {
        expect(FormatUtils.capitalize('a'), 'A');
      });
    });

    group('truncate', () {
      test('returns short string unchanged', () {
        expect(FormatUtils.truncate('hi', 10), 'hi');
      });

      test('truncates long string with default suffix', () {
        expect(FormatUtils.truncate('hello world', 8), 'hello...');
      });

      test('truncates with custom suffix', () {
        expect(FormatUtils.truncate('hello world', 8, suffix: '~'), 'hello w~');
      });

      test('returns string at exact max length unchanged', () {
        expect(FormatUtils.truncate('hello', 5), 'hello');
      });
    });

    group('camelCaseToTitle', () {
      test('converts camelCase to title case', () {
        // capitalize lowercases all chars after the first
        expect(FormatUtils.camelCaseToTitle('camelCase'), 'Camel case');
      });

      test('converts single word', () {
        expect(FormatUtils.camelCaseToTitle('hello'), 'Hello');
      });

      test('converts multi-word camelCase', () {
        // capitalize lowercases all chars after the first
        expect(
          FormatUtils.camelCaseToTitle('someHTTPResponse'),
          'Some h t t p response',
        );
      });

      test('handles already-capitalized first letter', () {
        expect(FormatUtils.camelCaseToTitle('Hello'), 'Hello');
      });
    });
  });
}
