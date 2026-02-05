import 'package:culcul/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  UserModel({
    required super.id,
    required super.username,
    super.avatarUrl,
    super.email,
    required super.createdAt,
    super.level,
    super.currentExp,
    super.nextExp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final levelInfo = json['level_info'] as Map<String, dynamic>?;
    return UserModel(
      id: json['mid'].toString(),
      username: json['uname'] as String,
      avatarUrl: json['face'] as String?,
      email: json['email'] as String?,
      createdAt: DateTime.now(), // API doesn't return created_at
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

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      avatarUrl: user.avatarUrl,
      email: user.email,
      createdAt: user.createdAt,
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: username,
      avatarUrl: avatarUrl,
      email: email,
      createdAt: createdAt,
    );
  }
}
