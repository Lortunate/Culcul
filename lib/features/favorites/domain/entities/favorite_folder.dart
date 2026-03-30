class FavoriteOwner {
  final int mid;
  final String name;
  final String face;

  const FavoriteOwner({required this.mid, required this.name, required this.face});
}

class FavoriteFolder {
  final int id;
  final int fid;
  final int mid;
  final int attr;
  final String title;
  final int favState;
  final int mediaCount;
  final String? cover;
  final FavoriteOwner? upper;
  final String? intro;
  final int? ctime;
  final int? mtime;
  final int? state;

  const FavoriteFolder({
    required this.id,
    required this.fid,
    required this.mid,
    required this.attr,
    required this.title,
    required this.favState,
    required this.mediaCount,
    required this.cover,
    required this.upper,
    required this.intro,
    required this.ctime,
    required this.mtime,
    required this.state,
  });

  FavoriteFolder copyWith({
    int? id,
    int? fid,
    int? mid,
    int? attr,
    String? title,
    int? favState,
    int? mediaCount,
    String? cover,
    FavoriteOwner? upper,
    String? intro,
    int? ctime,
    int? mtime,
    int? state,
  }) {
    return FavoriteFolder(
      id: id ?? this.id,
      fid: fid ?? this.fid,
      mid: mid ?? this.mid,
      attr: attr ?? this.attr,
      title: title ?? this.title,
      favState: favState ?? this.favState,
      mediaCount: mediaCount ?? this.mediaCount,
      cover: cover ?? this.cover,
      upper: upper ?? this.upper,
      intro: intro ?? this.intro,
      ctime: ctime ?? this.ctime,
      mtime: mtime ?? this.mtime,
      state: state ?? this.state,
    );
  }

  bool get isPrivate => attr != 0 && (attr & 1) == 1;
}

class FavoriteFolderPage {
  final int count;
  final List<FavoriteFolder> folders;

  const FavoriteFolderPage({required this.count, required this.folders});
}
