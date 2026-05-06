import 'package:culcul/core/utils/list_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ListUtils.mergeUnique', () {
    test('merges two lists with no overlap', () {
      final result = ListUtils.mergeUnique(
        [_Item(1, 'a'), _Item(2, 'b')],
        [_Item(3, 'c'), _Item(4, 'd')],
        idGetter: (item) => item.id,
      );

      expect(result, hasLength(4));
      expect(result.map((e) => e.id), [1, 2, 3, 4]);
    });

    test('deduplicates items with full overlap', () {
      final result = ListUtils.mergeUnique(
        [_Item(1, 'a'), _Item(2, 'b')],
        [_Item(1, 'a_updated'), _Item(2, 'b_updated')],
        idGetter: (item) => item.id,
      );

      expect(result, hasLength(2));
      expect(result[0].name, 'a');
      expect(result[1].name, 'b');
    });

    test('deduplicates only overlapping items with partial overlap', () {
      final result = ListUtils.mergeUnique(
        [_Item(1, 'a'), _Item(2, 'b')],
        [_Item(2, 'b_new'), _Item(3, 'c')],
        idGetter: (item) => item.id,
      );

      expect(result, hasLength(3));
      expect(result.map((e) => e.id), [1, 2, 3]);
      expect(result[1].name, 'b');
    });

    test('returns current list when newItems is empty', () {
      final current = [_Item(1, 'a')];
      final result = ListUtils.mergeUnique(
        current,
        <_Item>[],
        idGetter: (item) => item.id,
      );

      expect(result, same(current));
    });

    test('returns newItems when current list is empty', () {
      final newItems = [_Item(1, 'a')];
      final result = ListUtils.mergeUnique(
        <_Item>[],
        newItems,
        idGetter: (item) => item.id,
      );

      expect(result, same(newItems));
    });

    test('returns empty list when both lists are empty', () {
      final result = ListUtils.mergeUnique(
        <_Item>[],
        <_Item>[],
        idGetter: (item) => item.id,
      );

      expect(result, isEmpty);
    });

    test('works with custom idGetter using string field', () {
      final result = ListUtils.mergeUnique(
        [_Item(1, 'alpha'), _Item(2, 'beta')],
        [_Item(3, 'beta'), _Item(4, 'gamma')],
        idGetter: (item) => item.name,
      );

      expect(result, hasLength(3));
      expect(result.map((e) => e.name), ['alpha', 'beta', 'gamma']);
    });
  });
}

class _Item {
  final int id;
  final String name;

  _Item(this.id, this.name);
}
