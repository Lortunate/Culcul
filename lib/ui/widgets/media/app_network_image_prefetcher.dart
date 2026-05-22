import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;

import 'package:culcul/ui/widgets/media/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' show ProviderScope;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_network_image_prefetcher.g.dart';

@Riverpod(keepAlive: true)
AppNetworkImagePrefetcher appNetworkImagePrefetcher(Ref ref) {
  final prefetcher = AppNetworkImagePrefetcher();
  ref.onDispose(prefetcher.dispose);
  return prefetcher;
}

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
  AppNetworkImagePrefetcher({DateTime Function()? now}) : _now = now ?? DateTime.now;

  final DateTime Function() _now;
  final LinkedHashMap<String, DateTime> _prefetchedAtByKey =
      LinkedHashMap<String, DateTime>();
  final HashSet<String> _inFlightKeys = HashSet<String>();
  final Queue<_PrefetchTask> _queue = Queue<_PrefetchTask>();

  int _activeTasks = 0;
  bool _disposed = false;

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

    ProviderScope.containerOf(context, listen: false)
        .read(appNetworkImagePrefetcherProvider)
        .prefetchImages(
          context,
          specs: specs,
          limit: limit,
          maxConcurrency: maxConcurrency,
          queueCapacity: queueCapacity,
          ttl: ttl,
          lruCapacity: lruCapacity,
        );
  }

  @visibleForTesting
  int get queuedTaskCount => _queue.length;

  @visibleForTesting
  int get inFlightTaskCount => _inFlightKeys.length;

  @visibleForTesting
  int get rememberedKeyCount => _prefetchedAtByKey.length;

  @visibleForTesting
  bool get isDisposed => _disposed;

  void prefetchImages(
    BuildContext context, {
    required List<NetworkImagePrefetchSpec> specs,
    int limit = 6,
    int maxConcurrency = 2,
    int queueCapacity = 60,
    Duration ttl = const Duration(minutes: 15),
    int lruCapacity = 500,
  }) {
    if (_disposed) {
      return;
    }
    if (!context.mounted || specs.isEmpty || limit <= 0) {
      return;
    }

    _evictExpired(ttl);
    final positiveQueueCapacity = math.max(1, queueCapacity);
    final positiveLruCapacity = math.max(1, lruCapacity);
    final imageConfiguration = createLocalImageConfiguration(context);

    for (final spec in specs.take(math.max(0, limit))) {
      if (spec.url.isEmpty) {
        continue;
      }

      final provider = AppNetworkImage.providerFor(
        url: spec.url,
        memCacheWidth: spec.memCacheWidth,
        memCacheHeight: spec.memCacheHeight,
      );
      final cacheKey = _cacheKeyFor(spec);
      if (_isPrefetched(cacheKey, ttl) || _inFlightKeys.contains(cacheKey)) {
        continue;
      }

      _inFlightKeys.add(cacheKey);
      _queue.addLast(
        _PrefetchTask(
          cacheKey: cacheKey,
          provider: provider,
          imageConfiguration: imageConfiguration,
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

  void dispose() {
    _disposed = true;
    _queue.clear();
    _inFlightKeys.clear();
    _prefetchedAtByKey.clear();
  }

  void _drain({required int maxConcurrency}) {
    if (_disposed) {
      return;
    }
    while (_activeTasks < maxConcurrency && _queue.isNotEmpty) {
      final task = _queue.removeFirst();
      _activeTasks++;
      unawaited(_runTask(task, maxConcurrency));
    }
  }

  Future<void> _runTask(_PrefetchTask task, int maxConcurrency) async {
    try {
      if (_disposed) {
        _forget(task.cacheKey);
        return;
      }

      await _precacheImage(task.provider, task.imageConfiguration);
      if (!_disposed) {
        _rememberPrefetched(task.cacheKey, task.lruCapacity);
      }
    } catch (_) {
      _forget(task.cacheKey);
    } finally {
      _inFlightKeys.remove(task.cacheKey);
      _activeTasks = math.max(0, _activeTasks - 1);
      _evictExpired(task.ttl);
      _drain(maxConcurrency: maxConcurrency);
    }
  }

  Future<void> _precacheImage(
    ImageProvider<Object> provider,
    ImageConfiguration imageConfiguration,
  ) {
    final completer = Completer<void>();
    final stream = provider.resolve(imageConfiguration);
    ImageStreamListener? listener;
    listener = ImageStreamListener(
      (image, synchronousCall) {
        if (!completer.isCompleted) {
          completer.complete();
        }
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          image.dispose();
          stream.removeListener(listener!);
        }, debugLabel: 'AppNetworkImagePrefetcher.removeListener');
      },
      onError: (exception, stackTrace) {
        if (!completer.isCompleted) {
          completer.complete();
        }
        stream.removeListener(listener!);
      },
    );
    stream.addListener(listener);
    return completer.future;
  }

  String _cacheKeyFor(NetworkImagePrefetchSpec spec) =>
      '${AppNetworkImage.resolveUrl(spec.url)}:${spec.memCacheWidth}:${spec.memCacheHeight}';

  bool _isPrefetched(String key, Duration ttl) {
    final ts = _prefetchedAtByKey[key];
    if (ts == null) {
      return false;
    }

    if (_now().difference(ts) > ttl) {
      _prefetchedAtByKey.remove(key);
      return false;
    }

    _prefetchedAtByKey.remove(key);
    _prefetchedAtByKey[key] = _now();
    return true;
  }

  void _rememberPrefetched(String key, int capacity) {
    _prefetchedAtByKey.remove(key);
    _prefetchedAtByKey[key] = _now();
    while (_prefetchedAtByKey.length > capacity) {
      _prefetchedAtByKey.remove(_prefetchedAtByKey.keys.first);
    }
  }

  void _evictExpired(Duration ttl) {
    if (_prefetchedAtByKey.isEmpty) {
      return;
    }

    final now = _now();
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

  void _forget(String key) {
    _prefetchedAtByKey.remove(key);
  }
}

class _PrefetchTask {
  final String cacheKey;
  final ImageProvider<Object> provider;
  final ImageConfiguration imageConfiguration;
  final Duration ttl;
  final int lruCapacity;

  const _PrefetchTask({
    required this.cacheKey,
    required this.provider,
    required this.imageConfiguration,
    required this.ttl,
    required this.lruCapacity,
  });
}
