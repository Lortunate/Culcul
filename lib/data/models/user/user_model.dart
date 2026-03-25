import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
sealed class User with _$User {
  const User._();

  const factory User({
    required String id,
    required String username,
    String? avatarUrl,
    String? email,
    required DateTime createdAt,
    int? level,
    int? currentExp,
    int? nextExp,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) {
    final levelInfo = json['level_info'] as Map<String, dynamic>?;
    return User(
      id: json['mid']?.toString() ?? '',
      username: json['uname'] as String? ?? '',
      avatarUrl: json['face'] as String?,
      email: json['email'] as String?,
      createdAt: DateTime.now(),
      level: levelInfo?['current_level'] as int?,
      currentExp: levelInfo?['current_exp'] as int?,
      nextExp: levelInfo?['next_exp'] as int?,
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

