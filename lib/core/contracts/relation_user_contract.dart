class RelationOfficialVerify {
  final int type;
  final String desc;

  const RelationOfficialVerify({required this.type, required this.desc});
}

class RelationVipInfo {
  final int vipType;
  final int vipStatus;
  final String nicknameColor;

  const RelationVipInfo({
    required this.vipType,
    required this.vipStatus,
    required this.nicknameColor,
  });
}

class ProfileRelationUser {
  final int mid;
  final String uname;
  final String face;
  final String sign;
  final int attribute;
  final RelationOfficialVerify? officialVerify;
  final RelationVipInfo? vip;
  final int mtime;
  final int special;

  const ProfileRelationUser({
    required this.mid,
    required this.uname,
    required this.face,
    required this.sign,
    required this.attribute,
    required this.officialVerify,
    required this.vip,
    required this.mtime,
    required this.special,
  });
}
