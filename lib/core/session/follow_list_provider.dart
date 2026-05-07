import 'package:culcul/core/contracts/follow_list_contract.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides follow list service. Must be overridden at bootstrap.
final followListServiceProvider = Provider<FollowListService>((ref) {
  throw UnimplementedError('followListServiceProvider must be overridden at bootstrap');
});
