import 'package:culcul/core/utils/id_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IdUtils.bv2av', () {
    test('converts BV17x411w7KC to AV 170001', () {
      expect(IdUtils.bv2av('BV17x411w7KC'), 170001);
    });

    test('converts BV1GJ411x7h7 to its AV ID', () {
      expect(IdUtils.bv2av('BV1GJ411x7h7'), 80433022);
    });

    test('converts BV1xx411c7mD to its AV ID', () {
      expect(IdUtils.bv2av('BV1xx411c7mD'), 2);
    });

    test('adds BV prefix when missing', () {
      // '17x411w7KC' is 10 chars, code prepends 'BV' → 'BV17x411w7KC'
      expect(IdUtils.bv2av('17x411w7KC'), 170001);
    });

    test('returns 0 for too-short input', () {
      expect(IdUtils.bv2av('BV123'), 0);
    });

    test('returns 0 for empty string', () {
      expect(IdUtils.bv2av(''), 0);
    });

    test('returns 0 for wrong-length input after prefix is added', () {
      // '12345' is 5 chars, prepended 'BV' → 'BV12345' is 7 chars, not 12
      expect(IdUtils.bv2av('12345'), 0);
    });
  });
}
