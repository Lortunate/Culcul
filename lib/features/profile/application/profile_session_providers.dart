import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/contracts/user_profile_lookup_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/application/profile_lookup_adapter.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef FetchUserCard = Future<Result<UserCardModel, AppError>> Function(int mid);

final userCardProvider = Provider<FetchUserCard>((ref) {
  return (mid) => ref.read(profileRepositoryProvider).getUserCard(mid);
});

final userProfileLookupProvider = Provider<UserProfileLookup>((ref) {
  return ProfileLookupAdapter(ref);
});

final userProfileInfoProvider = FutureProvider.autoDispose
    .family<UserProfileInfo?, String>((ref, mid) async {
      final lookup = ref.read(userProfileLookupProvider);
      final result = await lookup.getUserProfile(mid);
      return result.dataOrNull;
    });
