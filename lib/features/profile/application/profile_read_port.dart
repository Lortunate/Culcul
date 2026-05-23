import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/domain/entities/profile_user.dart';

/// Profile read-model application boundary.
abstract interface class ProfileReadPort {
  Future<Result<ProfileUser, AppError>> getProfile(int userId);

  Future<Result<ProfileUser, AppError>> getProfileModel(int userId);

  Future<Result<UserCardModel, AppError>> getUserCard(int mid);
}
