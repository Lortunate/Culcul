import 'package:culcul/core/contracts/follow_list_contract.dart';
import 'package:culcul/core/contracts/watch_later_port.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides follow list service. Must be overridden at bootstrap.
final followListServiceProvider = Provider<FollowListService>((ref) {
  throw UnimplementedError('followListServiceProvider must be overridden at bootstrap');
});

/// Provides watch-later actions. Must be overridden at bootstrap.
final watchLaterPortProvider = Provider<WatchLaterPort>((ref) {
  throw UnimplementedError('watchLaterPortProvider must be overridden at bootstrap');
});
