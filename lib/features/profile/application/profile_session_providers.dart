import 'package:culcul/core/contracts/user_profile_lookup_contract.dart';
import 'package:culcul/features/profile/application/profile_lookup_adapter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_session_providers.g.dart';

@Riverpod(keepAlive: true)
UserProfileLookup userProfileLookup(Ref ref) {
  return ProfileLookupAdapter(ref);
}

@riverpod
Future<UserProfileInfo?> userProfileInfo(Ref ref, String mid) async {
  final lookup = ref.read(userProfileLookupProvider);
  final result = await lookup.getUserProfile(mid);
  return result.dataOrNull;
}
