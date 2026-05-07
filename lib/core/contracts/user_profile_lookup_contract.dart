import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';

/// Minimal user profile info needed by features outside profile.
/// Used by notification to display chat partner info.
abstract interface class UserProfileLookup {
  Future<Result<UserProfileInfo, AppError>> getUserProfile(String mid);
}

class UserProfileInfo {
  final String mid;
  final String name;
  final String avatarUrl;

  const UserProfileInfo({
    required this.mid,
    required this.name,
    required this.avatarUrl,
  });
}
