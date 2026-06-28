final class UserCardModel {
  const UserCardModel({
    required this.mid,
    required this.name,
    required this.face,
    this.isFollowed = false,
  });

  final String mid;
  final String name;
  final String face;
  final bool isFollowed;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UserCardModel &&
            runtimeType == other.runtimeType &&
            mid == other.mid &&
            name == other.name &&
            face == other.face &&
            isFollowed == other.isFollowed;
  }

  @override
  int get hashCode => Object.hash(runtimeType, mid, name, face, isFollowed);

  @override
  String toString() {
    return 'UserCardModel('
        'mid: $mid, '
        'name: $name, '
        'face: $face, '
        'isFollowed: $isFollowed'
        ')';
  }
}
