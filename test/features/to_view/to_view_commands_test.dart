import 'package:culcul/features/to_view/application/to_view_commands.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('planToViewClearAll', () {
    test('returns unavailable when not logged in', () {
      final result = planToViewClearAll(isLoggedIn: false, itemCount: 5);
      expect(result, ToViewClearAllAction.unavailable);
    });

    test('returns unavailable when item count is zero', () {
      final result = planToViewClearAll(isLoggedIn: true, itemCount: 0);
      expect(result, ToViewClearAllAction.unavailable);
    });

    test('returns unavailable when item count is negative', () {
      final result = planToViewClearAll(isLoggedIn: true, itemCount: -1);
      expect(result, ToViewClearAllAction.unavailable);
    });

    test('returns confirm when logged in with items', () {
      final result = planToViewClearAll(isLoggedIn: true, itemCount: 3);
      expect(result, ToViewClearAllAction.confirm);
    });
  });

  group('executeConfirmedToViewClearAll', () {
    test('executes clearAll callback on confirm action', () async {
      var called = false;

      final result = await executeConfirmedToViewClearAll(
        action: ToViewClearAllAction.confirm,
        clearAll: () async {
          called = true;
        },
      );

      expect(result, isTrue);
      expect(called, isTrue);
    });

    test('does nothing on unavailable action', () async {
      var called = false;

      final result = await executeConfirmedToViewClearAll(
        action: ToViewClearAllAction.unavailable,
        clearAll: () async {
          called = true;
        },
      );

      expect(result, isFalse);
      expect(called, isFalse);
    });
  });

  group('refreshToViewWorkflow', () {
    test('returns success when refresh completes', () async {
      final result = await refreshToViewWorkflow(refresh: () async {});
      expect(result, IndicatorResult.success);
    });

    test('returns fail when refresh throws', () async {
      final result = await refreshToViewWorkflow(
        refresh: () async => throw Exception('network error'),
      );
      expect(result, IndicatorResult.fail);
    });
  });
}
