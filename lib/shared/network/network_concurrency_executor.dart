import 'package:culcul/core/core.dart';
import 'package:culcul/shared/network/network_concurrency_profiles.dart';
import 'package:culcul/core/perf/network_perf_logger.dart';
import 'package:pool/pool.dart';

typedef AsyncMapper<T, R> = Future<R> Function(T item);
typedef AsyncTask<T> = Future<T> Function();

class ConcurrentTask<T> {
  final String label;
  final bool critical;
  final AsyncTask<T> task;
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
    required AsyncMapper<T, R> mapper,
  }) async {
    if (items.isEmpty) {
      return <R>[];
    }

    final maxConcurrency = profile.maxConcurrency;
    final pool = Pool(maxConcurrency);
    final groupWatch = Stopwatch()..start();
    final results = List<R?>.filled(items.length, null);
    final tasks = <Future<void>>[];

    for (var index = 0; index < items.length; index++) {
      tasks.add(() async {
        final queuedAtUs = groupWatch.elapsedMicroseconds;
        final resource = await pool.request();
        final waitUs = groupWatch.elapsedMicroseconds - queuedAtUs;
        if (waitUs > 0) {
          NetworkPerfLogger.log(
            NetworkPerfEvent.queueWait,
            fields: <String, Object?>{
              'scope': scope,
              'profile': profile.name,
              'index': index,
              'wait_us': waitUs,
            },
          );
        }

        final taskWatch = Stopwatch()..start();
        try {
          results[index] = await mapper(items[index]);
          NetworkPerfLogger.log(
            NetworkPerfEvent.taskSuccess,
            fields: <String, Object?>{
              'scope': scope,
              'profile': profile.name,
              'index': index,
              'elapsed_ms': taskWatch.elapsedMilliseconds,
            },
          );
        } catch (error) {
          NetworkPerfLogger.log(
            NetworkPerfEvent.taskFailure,
            fields: <String, Object?>{
              'scope': scope,
              'profile': profile.name,
              'index': index,
              'elapsed_ms': taskWatch.elapsedMilliseconds,
              'error': error.toString(),
            },
          );
          rethrow;
        } finally {
          resource.release();
        }
      }());
    }

    try {
      await Future.wait(tasks, eagerError: true);
    } finally {
      await pool.close();
      NetworkPerfLogger.log(
        NetworkPerfEvent.groupComplete,
        fields: <String, Object?>{
          'scope': scope,
          'profile': profile.name,
          'elapsed_ms': groupWatch.elapsedMilliseconds,
          'size': items.length,
          'concurrency': maxConcurrency,
        },
      );
    }

    return results.cast<R>();
  }

  Future<Map<String, dynamic>> runConcurrent({
    required List<ConcurrentTask<dynamic>> tasks,
    required NetworkConcurrencyProfile profile,
    required String scope,
  }) async {
    if (tasks.isEmpty) {
      return const <String, dynamic>{};
    }

    final maxConcurrency = profile.maxConcurrency;
    final pool = Pool(maxConcurrency);
    final groupWatch = Stopwatch()..start();
    final results = <String, dynamic>{};
    final futures = <Future<void>>[];

    for (final task in tasks) {
      futures.add(() async {
        final queuedAtUs = groupWatch.elapsedMicroseconds;
        final resource = await pool.request();
        final waitUs = groupWatch.elapsedMicroseconds - queuedAtUs;
        if (waitUs > 0) {
          NetworkPerfLogger.log(
            NetworkPerfEvent.queueWait,
            fields: <String, Object?>{
              'scope': scope,
              'profile': profile.name,
              'task': task.label,
              'wait_us': waitUs,
            },
          );
        }

        final taskWatch = Stopwatch()..start();
        try {
          results[task.label] = await task.task();
          NetworkPerfLogger.log(
            NetworkPerfEvent.taskSuccess,
            fields: <String, Object?>{
              'scope': scope,
              'profile': profile.name,
              'task': task.label,
              'critical': task.critical,
              'elapsed_ms': taskWatch.elapsedMilliseconds,
            },
          );
        } catch (error) {
          final appError = error is AppError ? error : AppError.fromObject(error);
          if (task.critical) {
            NetworkPerfLogger.log(
              NetworkPerfEvent.taskFailure,
              fields: <String, Object?>{
                'scope': scope,
                'profile': profile.name,
                'task': task.label,
                'critical': true,
                'elapsed_ms': taskWatch.elapsedMilliseconds,
                'error': appError.message,
              },
            );
            throw appError;
          }

          results[task.label] = task.fallback?.call(appError);
          NetworkPerfLogger.log(
            NetworkPerfEvent.taskFallback,
            fields: <String, Object?>{
              'scope': scope,
              'profile': profile.name,
              'task': task.label,
              'elapsed_ms': taskWatch.elapsedMilliseconds,
              'error': appError.message,
            },
          );
        } finally {
          resource.release();
        }
      }());
    }

    try {
      await Future.wait(futures, eagerError: true);
      return results;
    } finally {
      await pool.close();
      NetworkPerfLogger.log(
        NetworkPerfEvent.groupComplete,
        fields: <String, Object?>{
          'scope': scope,
          'profile': profile.name,
          'elapsed_ms': groupWatch.elapsedMilliseconds,
          'size': tasks.length,
          'concurrency': maxConcurrency,
        },
      );
    }
  }
}
