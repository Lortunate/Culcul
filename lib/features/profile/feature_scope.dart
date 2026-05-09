import 'package:culcul/core/session/feature_action_providers.dart';
import 'package:culcul/core/session/relation_providers.dart';
import 'package:culcul/core/session/user_providers.dart';
import 'package:culcul/features/profile/application/follow_list_adapter.dart';
import 'package:culcul/features/profile/application/profile_lookup_adapter.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:riverpod/misc.dart' show Override;

export 'data/profile_cache_repository.dart' show profileCacheRepositoryProvider;
export 'data/profile_repository_impl.dart' show profileRepositoryProvider;
export 'data/relation_repository_impl.dart' show relationRepositoryProvider;

class ProfileFeatureScope {
  const ProfileFeatureScope._();

  static List<Override> overrides() {
    return [
      userCardProvider.overrideWith((ref) {
        return (mid) => ref.read(profileRepositoryProvider).getUserCard(mid);
      }),
      userProfileLookupProvider.overrideWith((ref) {
        return ProfileLookupAdapter(ref);
      }),
      modifyRelationProvider.overrideWith((ref) {
        return ({required mid, required isFollow}) => ref
            .read(profileRepositoryProvider)
            .modifyRelation(mid: mid, isFollow: isFollow);
      }),
      followListServiceProvider.overrideWith((ref) {
        return FollowListAdapter(ref);
      }),
    ];
  }
}
