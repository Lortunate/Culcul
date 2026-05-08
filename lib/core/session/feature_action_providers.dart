import 'package:culcul/core/contracts/follow_list_contract.dart';
import 'package:culcul/core/contracts/watch_later_contract.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides follow list service. Must be overridden at bootstrap.
final followListServiceProvider = Provider<FollowListService>((ref) {
  throw UnimplementedError('followListServiceProvider must be overridden at bootstrap');
});

/// Provides watch-later actions. Must be overridden at bootstrap.
final watchLaterActionsProvider = Provider<WatchLaterActions>((ref) {
  throw UnimplementedError('watchLaterActionsProvider must be overridden at bootstrap');
});
