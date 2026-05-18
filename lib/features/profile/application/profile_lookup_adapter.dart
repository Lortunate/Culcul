import 'package:culcul/core/contracts/user_profile_lookup_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Bridges core's UserProfileLookup contract with profile's repository.
class ProfileLookupAdapter implements UserProfileLookup {
  final Ref _ref;
  ProfileLookupAdapter(this._ref);

  @override
  Future<Result<UserProfileInfo, AppError>> getUserProfile(String mid) async {
    try {
      final profile = await _ref.read(userProfileProvider(mid).future);
      return Success(
        UserProfileInfo(
          mid: profile.id,
          name: profile.username,
          face: profile.avatarUrl ?? '',
        ),
      );
    } catch (e) {
      return Failure(ServerAppError('Failed to fetch user profile: $e'));
    }
  }

  @override
  Future<Result<UserCardModel, AppError>> getUserCard(String mid) async {
    final uid = int.tryParse(mid);
    if (uid == null) {
      return Failure(ServerAppError('Invalid user id: $mid'));
    }
    return _ref.read(profileRepositoryProvider).getUserCard(uid);
  }
}
