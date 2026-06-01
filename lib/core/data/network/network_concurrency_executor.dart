import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/data/network/network_concurrency_profiles.dart';
import 'package:culcul/core/data/network/semaphore.dart';

class ConcurrentTask<T> {
  final String label;
  final bool critical;
  final Future<T> Function() task;
  final T Function(AppError error)? fallback;

  const ConcurrentTask({
    required this.label,
    required this.task,
    this.critical = true,
    this.fallback,
  });
}

class NetworkConcurrencyExecutor {
  const NetworkConcurrencyExecutor();

  Future<List<R>> mapConcurrent<T, R>({
    required List<T> items,
    required NetworkConcurrencyProfile profile,
    required String scope,
    required Future<R> Function(T item) mapper,
  }) async {
    if (items.isEmpty) return <R>[];

    final semaphore = Semaphore(profile.maxConcurrency);
    final results = List<R?>.filled(items.length, null);
    final futures = <Future<void>>[];

    for (var i = 0; i < items.length; i++) {
      futures.add(() async {
        await semaphore.acquire();
        try {
          results[i] = await mapper(items[i]);
        } finally {
          semaphore.release();
        }
      }());
    }

    await Future.wait(futures, eagerError: true);
    return results.cast<R>();
  }

  Future<Map<String, dynamic>> runConcurrent({
    required List<ConcurrentTask<dynamic>> tasks,
    required NetworkConcurrencyProfile profile,
    required String scope,
  }) async {
    if (tasks.isEmpty) return const <String, dynamic>{};

    final semaphore = Semaphore(profile.maxConcurrency);
    final results = <String, dynamic>{};
    final futures = <Future<void>>[];

    for (final task in tasks) {
      futures.add(() async {
        await semaphore.acquire();
        try {
          results[task.label] = await task.task();
        } catch (error) {
          final appError = error is AppError ? error : AppError.fromObject(error);
          if (task.critical) throw appError;
          results[task.label] = task.fallback?.call(appError);
        } finally {
          semaphore.release();
        }
      }());
    }

    await Future.wait(futures, eagerError: true);
    return results;
  }
}
