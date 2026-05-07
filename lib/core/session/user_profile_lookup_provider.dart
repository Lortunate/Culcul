import 'package:culcul/core/contracts/user_profile_lookup_contract.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides user profile lookup. Must be overridden at bootstrap.
final userProfileLookupProvider = Provider<UserProfileLookup>((ref) {
  throw UnimplementedError('userProfileLookupProvider must be overridden at bootstrap');
});

/// Convenience provider that fetches a user profile by ID.
/// Returns null if not found or on error.
final userProfileInfoProvider = FutureProvider.autoDispose
    .family<UserProfileInfo?, String>((ref, mid) async {
      final lookup = ref.read(userProfileLookupProvider);
      final result = await lookup.getUserProfile(mid);
      return result.dataOrNull;
    });
