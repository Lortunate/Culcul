import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/profile/data/profile_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_user_card_lookup.g.dart';

@riverpod
ProfileUserCardLookup profileUserCardLookup(Ref ref) {
  return ProfileUserCardLookup(ref.watch(profileRepositoryProvider));
}

class ProfileUserCardLookup {
  const ProfileUserCardLookup(this._repository);

  final ProfileRepositoryImpl _repository;

  Future<Result<UserCardModel, AppError>> getUserCard(int mid) {
    return _repository.getUserCard(mid);
  }
}
