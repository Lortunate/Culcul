import 'package:culcul/features/auth/domain/entities/user_entity.dart';

class AuthUserDto {
  final String id;
  final String username;
  final String? avatarUrl;
  final String? email;
  final DateTime createdAt;
  final int? level;
  final int? currentExp;
  final int? nextExp;

  const AuthUserDto({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.email,
    required this.createdAt,
    this.level,
    this.currentExp,
    this.nextExp,
  });

  factory AuthUserDto.fromJson(Map<String, dynamic> json) {
    final levelInfo = json['level_info'] as Map<String, dynamic>?;
    final createdAtRaw = json['created_at'];
    final createdAt = createdAtRaw is String
        ? DateTime.tryParse(createdAtRaw) ?? DateTime.now()
        : DateTime.now();

    return AuthUserDto(
      id: json['mid']?.toString() ?? '',
      username: json['uname'] as String? ?? '',
      avatarUrl: json['face'] as String?,
      email: json['email'] as String?,
      createdAt: createdAt,
      level: _asInt(levelInfo?['current_level']),
      currentExp: _asInt(levelInfo?['current_exp']),
      nextExp: _asInt(levelInfo?['next_exp']),
    );
  }

  factory AuthUserDto.fromDomain(UserEntity entity) {
    return AuthUserDto(
      id: entity.id,
      username: entity.username,
      avatarUrl: entity.avatarUrl,
      email: entity.email,
      createdAt: entity.createdAt,
      level: entity.level,
      currentExp: entity.currentExp,
      nextExp: entity.nextExp,
    );
  }

  UserEntity toDomain() {
    return UserEntity(
      id: id,
      username: username,
      avatarUrl: avatarUrl,
      email: email,
      createdAt: createdAt,
      level: level,
      currentExp: currentExp,
      nextExp: nextExp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mid': id,
      'uname': username,
      'face': avatarUrl,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'level_info': {
        'current_level': level,
        'current_exp': currentExp,
        'next_exp': nextExp,
      },
    };
  }

  static int? _asInt(Object? value) {
    return switch (value) {
      final int v => v,
      final num v => v.toInt(),
      _ => null,
    };
  }
}
