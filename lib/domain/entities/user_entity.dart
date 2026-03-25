class UserEntity {
  final String id;
  final String username;
  final String? avatarUrl;
  final String? email;
  final DateTime createdAt;
  final int? level;
  final int? currentExp;
  final int? nextExp;

  UserEntity({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.email,
    required this.createdAt,
    this.level,
    this.currentExp,
    this.nextExp,
  });

  UserEntity copyWith({
    String? id,
    String? username,
    String? avatarUrl,
    String? email,
    DateTime? createdAt,
    int? level,
    int? currentExp,
    int? nextExp,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      level: level ?? this.level,
      currentExp: currentExp ?? this.currentExp,
      nextExp: nextExp ?? this.nextExp,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          avatarUrl == other.avatarUrl &&
          email == other.email &&
          createdAt == other.createdAt &&
          level == other.level &&
          currentExp == other.currentExp &&
          nextExp == other.nextExp;

  @override
  int get hashCode =>
      id.hashCode ^
      username.hashCode ^
      avatarUrl.hashCode ^
      email.hashCode ^
      createdAt.hashCode ^
      level.hashCode ^
      currentExp.hashCode ^
      nextExp.hashCode;
}

