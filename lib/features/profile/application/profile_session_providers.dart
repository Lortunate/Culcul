import 'package:culcul/core/contracts/relation_port.dart';
import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/contracts/user_profile_lookup_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/application/profile_lookup_adapter.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:culcul/features/profile/data/relation_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef FetchUserCard = Future<Result<UserCardModel, AppError>> Function(int mid);
typedef ModifyRelation =
    Future<Result<void, AppError>> Function({required int mid, required bool isFollow});

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

final relationPortProvider = Provider<RelationPort>((ref) {
  return ref.read(relationRepositoryProvider);
});

final modifyRelationProvider = Provider<ModifyRelation>((ref) {
  return ({required mid, required isFollow}) => ref
      .read(profileRepositoryProvider)
      .modifyRelation(mid: mid, isFollow: isFollow);
});
