import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/application/user_profile_info.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_session_providers.g.dart';

@riverpod
Future<UserProfileInfo?> userProfileInfo(Ref ref, String mid) async {
  final uid = int.tryParse(mid);
  if (uid == null) {
    return null;
  }

  final result = await ref.read(profileRepositoryProvider).getProfileModel(uid);
  return result.when(
    success: (profile) => UserProfileInfo(
      mid: profile.id,
      name: profile.username,
      face: profile.avatarUrl ?? '',
    ),
    failure: (_) => null,
  );
}

@riverpod
Future<Result<UserCardModel, AppError>> userProfileCard(Ref ref, String mid) async {
  final uid = int.tryParse(mid);
  if (uid == null) {
    return Failure(ServerAppError('Invalid user id: $mid'));
  }
  return ref.read(profileRepositoryProvider).getUserCard(uid);
}
