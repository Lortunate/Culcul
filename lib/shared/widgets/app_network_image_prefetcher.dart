import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:culcul/shared/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImagePrefetchSpec {
  final String url;
  final int? memCacheWidth;
  final int? memCacheHeight;

  const NetworkImagePrefetchSpec({
    required this.url,
    this.memCacheWidth,
    this.memCacheHeight,
  });
}

class AppNetworkImagePrefetcher {
  AppNetworkImagePrefetcher._();

  static final LinkedHashMap<String, DateTime> _prefetchedAtByKey =
      LinkedHashMap<String, DateTime>();
  static final HashSet<String> _inFlightKeys = HashSet<String>();
  static final Queue<_PrefetchTask> _queue = Queue<_PrefetchTask>();

  static int _activeTasks = 0;

  static void prefetch(
    BuildContext context, {
    required List<NetworkImagePrefetchSpec> specs,
    int limit = 6,
    int maxConcurrency = 2,
    int queueCapacity = 60,
    Duration ttl = const Duration(minutes: 15),
    int lruCapacity = 500,
  }) {
    if (!context.mounted || specs.isEmpty || limit <= 0) {
      return;
    }

    _evictExpired(ttl);
    final positiveQueueCapacity = math.max(1, queueCapacity);
    final positiveLruCapacity = math.max(1, lruCapacity);

    for (final spec in specs.take(math.max(0, limit))) {
      if (spec.url.isEmpty) {
        continue;
      }

      final cacheKey =
          '${AppNetworkImage.resolveUrl(spec.url)}:${spec.memCacheWidth}:${spec.memCacheHeight}';
      if (_isPrefetched(cacheKey, ttl) || _inFlightKeys.contains(cacheKey)) {
        continue;
      }

      _inFlightKeys.add(cacheKey);
      _queue.addLast(
        _PrefetchTask(
          context: context,
          cacheKey: cacheKey,
          spec: spec,
          ttl: ttl,
          lruCapacity: positiveLruCapacity,
        ),
      );
      while (_queue.length > positiveQueueCapacity) {
        final dropped = _queue.removeFirst();
        _inFlightKeys.remove(dropped.cacheKey);
      }
    }

    _drain(maxConcurrency: math.max(1, maxConcurrency));
  }

  static void _drain({required int maxConcurrency}) {
    while (_activeTasks < maxConcurrency && _queue.isNotEmpty) {
      final task = _queue.removeFirst();
      _activeTasks++;
      unawaited(_runTask(task, maxConcurrency));
    }
  }

  static Future<void> _runTask(_PrefetchTask task, int maxConcurrency) async {
    try {
      if (!task.context.mounted) {
        _forget(task.cacheKey);
        return;
      }

      await precacheImage(
        AppNetworkImage.providerFor(
          url: task.spec.url,
          memCacheWidth: task.spec.memCacheWidth,
          memCacheHeight: task.spec.memCacheHeight,
        ),
        task.context,
      );
      _rememberPrefetched(task.cacheKey, task.lruCapacity);
    } catch (_) {
      _forget(task.cacheKey);
    } finally {
      _inFlightKeys.remove(task.cacheKey);
      _activeTasks = math.max(0, _activeTasks - 1);
      _evictExpired(task.ttl);
      _drain(maxConcurrency: maxConcurrency);
    }
  }

  static bool _isPrefetched(String key, Duration ttl) {
    final ts = _prefetchedAtByKey[key];
    if (ts == null) {
      return false;
    }

    if (DateTime.now().difference(ts) > ttl) {
      _prefetchedAtByKey.remove(key);
      return false;
    }

    _prefetchedAtByKey.remove(key);
    _prefetchedAtByKey[key] = DateTime.now();
    return true;
  }

  static void _rememberPrefetched(String key, int capacity) {
    _prefetchedAtByKey.remove(key);
    _prefetchedAtByKey[key] = DateTime.now();
    while (_prefetchedAtByKey.length > capacity) {
      _prefetchedAtByKey.remove(_prefetchedAtByKey.keys.first);
    }
  }

  static void _evictExpired(Duration ttl) {
    if (_prefetchedAtByKey.isEmpty) {
      return;
    }

    final now = DateTime.now();
    final expired = <String>[];
    for (final entry in _prefetchedAtByKey.entries) {
      if (now.difference(entry.value) > ttl) {
        expired.add(entry.key);
      }
    }
    for (final key in expired) {
      _prefetchedAtByKey.remove(key);
    }
  }

  static void _forget(String key) {
    _prefetchedAtByKey.remove(key);
  }
}

class _PrefetchTask {
  final BuildContext context;
  final String cacheKey;
  final NetworkImagePrefetchSpec spec;
  final Duration ttl;
  final int lruCapacity;

  const _PrefetchTask({
    required this.context,
    required this.cacheKey,
    required this.spec,
    required this.ttl,
    required this.lruCapacity,
  });
}
