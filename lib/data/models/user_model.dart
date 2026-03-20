import 'package:culcul/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String username,
    String? avatarUrl,
    String? email,
    DateTime? createdAt,
    int? level,
    int? currentExp,
    int? nextExp,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final levelInfo = json['level_info'] as Map<String, dynamic>?;
    return UserModel(
      id: json['mid'].toString(),
      username: json['uname'] as String,
      avatarUrl: json['face'] as String?,
      email: json['email'] as String?,
      createdAt: DateTime.now(),
      level: levelInfo?['current_level'] as int?,
      currentExp: levelInfo?['current_exp'] as int?,
      nextExp: levelInfo?['next_exp'] as int?,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      avatarUrl: user.avatarUrl,
      email: user.email,
      createdAt: user.createdAt,
      level: user.level,
      currentExp: user.currentExp,
      nextExp: user.nextExp,
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: username,
      avatarUrl: avatarUrl,
      email: email,
      createdAt: createdAt ?? DateTime.now(),
      level: level,
      currentExp: currentExp,
      nextExp: nextExp,
    );
  }

  Map<String, dynamic> toJson() => {
    'mid': id,
    'uname': username,
    'face': avatarUrl,
    'email': email,
    'level_info': {
      'current_level': level,
      'current_exp': currentExp,
      'next_exp': nextExp,
    },
  };
}
