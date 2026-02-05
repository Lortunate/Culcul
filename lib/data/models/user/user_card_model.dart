import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_card_model.freezed.dart';
part 'user_card_model.g.dart';

@freezed
abstract class UserCardModel with _$UserCardModel {
  const factory UserCardModel({
    required String mid,
    required String name,
    required String face,
    @Default(false) bool isFollowed,
  }) = _UserCardModel;

  factory UserCardModel.fromJson(Map<String, dynamic> json) =>
      _$UserCardModelFromJson(json);
}
