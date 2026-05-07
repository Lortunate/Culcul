import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/network_concurrency_executor.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkConcurrencyExecutor', () {
    test('mapConcurrent keeps order and limits max concurrency', () async {
      const executor = NetworkConcurrencyExecutor();
      var inFlight = 0;
      var maxInFlight = 0;

      final result = await executor.mapConcurrent<int, int>(
        items: <int>[1, 2, 3, 4, 5, 6],
        profile: NetworkConcurrencyProfile.upload,
        scope: 'test_map',
        mapper: (item) async {
          inFlight++;
          maxInFlight = inFlight > maxInFlight ? inFlight : maxInFlight;
          await Future<void>.delayed(const Duration(milliseconds: 30));
          inFlight--;
          return item * 2;
        },
      );

      expect(result, <int>[2, 4, 6, 8, 10, 12]);
      expect(maxInFlight, lessThanOrEqualTo(3));
    });

    test('runConcurrent falls back for optional failures', () async {
      const executor = NetworkConcurrencyExecutor();

      final result = await executor.runConcurrent(
        tasks: <ConcurrentTask<dynamic>>[
          ConcurrentTask<int>(label: 'critical', task: () async => 1),
          ConcurrentTask<int>(
            label: 'optional_fail',
            critical: false,
            fallback: (_) => 99,
            task: () async => throw AppError.data('optional failed'),
          ),
        ],
        profile: NetworkConcurrencyProfile.backgroundSync,
        scope: 'test_run_optional',
      );

      expect(result['critical'], 1);
      expect(result['optional_fail'], 99);
    });

    test('runConcurrent throws on first critical failure', () async {
      const executor = NetworkConcurrencyExecutor();

      await expectLater(
        executor.runConcurrent(
          tasks: <ConcurrentTask<dynamic>>[
            ConcurrentTask<void>(
              label: 'critical_fail',
              task: () async => throw AppError.server('boom'),
            ),
            ConcurrentTask<Object?>(
              label: 'optional',
              critical: false,
              fallback: (_) => null,
              task: () async => null,
            ),
          ],
          profile: NetworkConcurrencyProfile.backgroundSync,
          scope: 'test_run_critical',
        ),
        throwsA(isA<AppError>()),
      );
    });
  });
}
