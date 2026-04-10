import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_card_contract.freezed.dart';

@freezed
sealed class UserCardModel with _$UserCardModel {
  const factory UserCardModel({
    required String mid,
    required String name,
    required String face,
    @Default(false) bool isFollowed,
  }) = _UserCardModel;
}
