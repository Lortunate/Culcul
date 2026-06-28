final class UserEntity {
  const UserEntity({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.email,
    required this.createdAt,
    this.level,
    this.currentExp,
    this.nextExp,
  });

  final String id;
  final String username;
  final String? avatarUrl;
  final String? email;
  final DateTime createdAt;
  final int? level;
  final int? currentExp;
  final int? nextExp;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other.runtimeType == runtimeType &&
            other is UserEntity &&
            other.id == id &&
            other.username == username &&
            other.avatarUrl == avatarUrl &&
            other.email == email &&
            other.createdAt == createdAt &&
            other.level == level &&
            other.currentExp == currentExp &&
            other.nextExp == nextExp;
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    avatarUrl,
    email,
    createdAt,
    level,
    currentExp,
    nextExp,
  );

  @override
  String toString() {
    return 'UserEntity(id: $id, username: $username, avatarUrl: $avatarUrl, '
        'email: $email, createdAt: $createdAt, level: $level, '
        'currentExp: $currentExp, nextExp: $nextExp)';
  }
}
