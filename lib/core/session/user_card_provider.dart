import 'package:culcul/core/contracts/user_card_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef FetchUserCard = Future<Result<UserCardModel, AppError>> Function(int mid);

/// Fetches a user card by mid. Must be overridden at bootstrap.
final userCardProvider = Provider<FetchUserCard>((ref) {
  throw UnimplementedError('userCardProvider must be overridden at bootstrap');
});
