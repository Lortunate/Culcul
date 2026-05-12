import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_lookup_contract.freezed.dart';

/// Minimal user profile info needed by features outside profile.
/// Used by notification to display chat partner info.
abstract interface class UserProfileLookup {
  Future<Result<UserProfileInfo, AppError>> getUserProfile(String mid);
}

@freezed
sealed class UserProfileInfo with _$UserProfileInfo {
  const factory UserProfileInfo({
    required String mid,
    required String name,
    required String face,
  }) = _UserProfileInfo;
}
