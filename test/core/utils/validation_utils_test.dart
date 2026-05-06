import 'package:culcul/core/utils/validation_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ValidationUtils', () {
    group('isValidEmail', () {
      test('returns true for standard email', () {
        expect(ValidationUtils.isValidEmail('user@example.com'), isTrue);
      });

      test('returns true for email with dots and hyphens', () {
        expect(ValidationUtils.isValidEmail('first.last-name@sub.domain.com'), isTrue);
      });

      test('returns false for email without @', () {
        expect(ValidationUtils.isValidEmail('userexample.com'), isFalse);
      });

      test('returns false for email without domain', () {
        expect(ValidationUtils.isValidEmail('user@'), isFalse);
      });

      test('returns false for empty string', () {
        expect(ValidationUtils.isValidEmail(''), isFalse);
      });
    });

    group('isValidPassword', () {
      test('returns true for valid password', () {
        expect(ValidationUtils.isValidPassword('Abcdef1x'), isTrue);
      });

      test('returns false when too short', () {
        expect(ValidationUtils.isValidPassword('Abc1x'), isFalse);
      });

      test('returns false without uppercase', () {
        expect(ValidationUtils.isValidPassword('abcdef1x'), isFalse);
      });

      test('returns false without lowercase', () {
        expect(ValidationUtils.isValidPassword('ABCDEF1X'), isFalse);
      });

      test('returns false without digit', () {
        expect(ValidationUtils.isValidPassword('Abcdefgh'), isFalse);
      });
    });

    group('isValidPhone', () {
      test('returns true for 10-digit phone', () {
        expect(ValidationUtils.isValidPhone('1234567890'), isTrue);
      });

      test('returns true for phone with country code', () {
        expect(ValidationUtils.isValidPhone('+1 234-567-8901'), isTrue);
      });

      test('returns true for phone with parentheses', () {
        expect(ValidationUtils.isValidPhone('+1 (234) 567-8901'), isTrue);
      });

      test('returns false for short phone', () {
        expect(ValidationUtils.isValidPhone('123'), isFalse);
      });

      test('returns false for phone with letters', () {
        expect(ValidationUtils.isValidPhone('abc'), isFalse);
      });
    });

    group('isValidUrl', () {
      test('returns true for http URL with path', () {
        expect(ValidationUtils.isValidUrl('http://example.com/path'), isTrue);
      });

      test('returns true for https URL with query', () {
        expect(ValidationUtils.isValidUrl('https://example.com/path?q=1'), isTrue);
      });

      test('returns false for empty string', () {
        expect(ValidationUtils.isValidUrl(''), isFalse);
      });
    });

    group('isNotEmpty', () {
      test('returns false for null', () {
        expect(ValidationUtils.isNotEmpty(null), isFalse);
      });

      test('returns false for empty string', () {
        expect(ValidationUtils.isNotEmpty(''), isFalse);
      });

      test('returns false for whitespace-only string', () {
        expect(ValidationUtils.isNotEmpty('   '), isFalse);
      });

      test('returns true for non-empty string', () {
        expect(ValidationUtils.isNotEmpty('hello'), isTrue);
      });

      test('returns true for string with leading/trailing spaces', () {
        expect(ValidationUtils.isNotEmpty('  hello  '), isTrue);
      });
    });

    group('hasMinLength', () {
      test('returns true when length exceeds minimum', () {
        expect(ValidationUtils.hasMinLength('abcde', 3), isTrue);
      });

      test('returns true when length equals minimum', () {
        expect(ValidationUtils.hasMinLength('abc', 3), isTrue);
      });

      test('returns false when length is below minimum', () {
        expect(ValidationUtils.hasMinLength('ab', 3), isFalse);
      });
    });

    group('hasMaxLength', () {
      test('returns true when length is below maximum', () {
        expect(ValidationUtils.hasMaxLength('ab', 5), isTrue);
      });

      test('returns true when length equals maximum', () {
        expect(ValidationUtils.hasMaxLength('abcde', 5), isTrue);
      });

      test('returns false when length exceeds maximum', () {
        expect(ValidationUtils.hasMaxLength('abcdef', 5), isFalse);
      });
    });

    group('isInRange', () {
      test('returns true for value within range', () {
        expect(ValidationUtils.isInRange(5, 1, 10), isTrue);
      });

      test('returns true for value at lower bound', () {
        expect(ValidationUtils.isInRange(1, 1, 10), isTrue);
      });

      test('returns true for value at upper bound', () {
        expect(ValidationUtils.isInRange(10, 1, 10), isTrue);
      });

      test('returns false for value below range', () {
        expect(ValidationUtils.isInRange(0, 1, 10), isFalse);
      });

      test('returns false for value above range', () {
        expect(ValidationUtils.isInRange(11, 1, 10), isFalse);
      });
    });

    group('isPositive', () {
      test('returns true for positive value', () {
        expect(ValidationUtils.isPositive(1), isTrue);
      });

      test('returns false for zero', () {
        expect(ValidationUtils.isPositive(0), isFalse);
      });

      test('returns false for negative value', () {
        expect(ValidationUtils.isPositive(-1), isFalse);
      });
    });

    group('isNonNegative', () {
      test('returns true for positive value', () {
        expect(ValidationUtils.isNonNegative(1), isTrue);
      });

      test('returns true for zero', () {
        expect(ValidationUtils.isNonNegative(0), isTrue);
      });

      test('returns false for negative value', () {
        expect(ValidationUtils.isNonNegative(-1), isFalse);
      });
    });

    group('isAlphanumeric', () {
      test('returns true for alphanumeric string', () {
        expect(ValidationUtils.isAlphanumeric('abc123'), isTrue);
      });

      test('returns false for string with spaces', () {
        expect(ValidationUtils.isAlphanumeric('abc 123'), isFalse);
      });

      test('returns false for string with special characters', () {
        expect(ValidationUtils.isAlphanumeric('abc@123'), isFalse);
      });
    });

    group('isAlphabetic', () {
      test('returns true for alphabetic string', () {
        expect(ValidationUtils.isAlphabetic('abcdef'), isTrue);
      });

      test('returns false for string with digits', () {
        expect(ValidationUtils.isAlphabetic('abc123'), isFalse);
      });

      test('returns false for string with spaces', () {
        expect(ValidationUtils.isAlphabetic('abc def'), isFalse);
      });
    });

    group('isNumeric', () {
      test('returns true for numeric string', () {
        expect(ValidationUtils.isNumeric('12345'), isTrue);
      });

      test('returns false for string with letters', () {
        expect(ValidationUtils.isNumeric('123a'), isFalse);
      });

      test('returns false for negative number string', () {
        expect(ValidationUtils.isNumeric('-123'), isFalse);
      });
    });

    group('isValidInteger', () {
      test('returns true for valid integer string', () {
        expect(ValidationUtils.isValidInteger('42'), isTrue);
      });

      test('returns true for negative integer string', () {
        expect(ValidationUtils.isValidInteger('-7'), isTrue);
      });

      test('returns false for decimal string', () {
        expect(ValidationUtils.isValidInteger('3.14'), isFalse);
      });

      test('returns false for non-numeric string', () {
        expect(ValidationUtils.isValidInteger('abc'), isFalse);
      });
    });

    group('isValidDouble', () {
      test('returns true for valid double string', () {
        expect(ValidationUtils.isValidDouble('3.14'), isTrue);
      });

      test('returns true for integer string', () {
        expect(ValidationUtils.isValidDouble('42'), isTrue);
      });

      test('returns false for non-numeric string', () {
        expect(ValidationUtils.isValidDouble('abc'), isFalse);
      });
    });

    group('validateAll', () {
      test('returns true when all validations pass', () {
        expect(ValidationUtils.validateAll([true, true, true]), isTrue);
      });

      test('returns false when one validation fails', () {
        expect(ValidationUtils.validateAll([true, false, true]), isFalse);
      });

      test('returns true for empty list', () {
        expect(ValidationUtils.validateAll([]), isTrue);
      });
    });

    group('customValidation', () {
      test('delegates to custom validator and returns result', () {
        bool startsWithA(String v) => v.startsWith('A');
        expect(ValidationUtils.customValidation('Apple', startsWithA), isTrue);
        expect(ValidationUtils.customValidation('Banana', startsWithA), isFalse);
      });
    });
  });
}
