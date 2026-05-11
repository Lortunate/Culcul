import 'package:culcul/core/contracts/watch_later_port.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides watch-later actions. Must be overridden at bootstrap.
final watchLaterPortProvider = Provider<WatchLaterPort>((ref) {
  throw UnimplementedError('watchLaterPortProvider must be overridden at bootstrap');
});
