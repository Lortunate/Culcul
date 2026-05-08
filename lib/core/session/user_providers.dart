import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/contracts/user_profile_lookup_contract.dart';
import 'package:culcul/core/contracts/user_session_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provides the current user session. Returns null if not logged in.
/// Backed by auth's state at bootstrap time via ProviderScope override.
final currentUserProvider = Provider<UserSession?>((ref) {
  throw UnimplementedError('currentUserProvider must be overridden at bootstrap');
});

typedef FetchUserCard = Future<Result<UserCardModel, AppError>> Function(int mid);

/// Fetches a user card by mid. Must be overridden at bootstrap.
final userCardProvider = Provider<FetchUserCard>((ref) {
  throw UnimplementedError('userCardProvider must be overridden at bootstrap');
});

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
