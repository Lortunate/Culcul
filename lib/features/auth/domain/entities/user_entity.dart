import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
sealed class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String username,
    String? avatarUrl,
    String? email,
    required DateTime createdAt,
    int? level,
    int? currentExp,
    int? nextExp,
  }) = _UserEntity;
}
