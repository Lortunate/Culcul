final class OfficialVerify {
  const OfficialVerify({this.type = -1, this.desc = ''});

  factory OfficialVerify.fromJson(Map<String, dynamic> json) {
    return OfficialVerify(
      type: (json['type'] as num?)?.toInt() ?? -1,
      desc: json['desc'] as String? ?? '',
    );
  }

  final int type;
  final String desc;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is OfficialVerify &&
            runtimeType == other.runtimeType &&
            type == other.type &&
            desc == other.desc;
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, desc);

  @override
  String toString() {
    return 'OfficialVerify(type: $type, desc: $desc)';
  }
}

final class VipInfo {
  const VipInfo({this.vipType = 0, this.vipStatus = 0, this.nicknameColor = ''});

  factory VipInfo.fromJson(Map<String, dynamic> json) {
    return VipInfo(
      vipType: (json['vipType'] as num?)?.toInt() ?? 0,
      vipStatus: (json['vipStatus'] as num?)?.toInt() ?? 0,
      nicknameColor: json['nicknameColor'] as String? ?? '',
    );
  }

  final int vipType;
  final int vipStatus;
  final String nicknameColor;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is VipInfo &&
            runtimeType == other.runtimeType &&
            vipType == other.vipType &&
            vipStatus == other.vipStatus &&
            nicknameColor == other.nicknameColor;
  }

  @override
  int get hashCode => Object.hash(runtimeType, vipType, vipStatus, nicknameColor);

  @override
  String toString() {
    return 'VipInfo('
        'vipType: $vipType, '
        'vipStatus: $vipStatus, '
        'nicknameColor: $nicknameColor'
        ')';
  }
}

final class ProfileRelationUser {
  const ProfileRelationUser({
    required this.mid,
    required this.uname,
    required this.face,
    required this.sign,
    required this.attribute,
    this.officialVerify,
    this.vip,
    required this.mtime,
    required this.special,
  });

  factory ProfileRelationUser.fromJson(Map<String, dynamic> json) {
    return ProfileRelationUser(
      mid: (json['mid'] as num).toInt(),
      uname: json['uname'] as String,
      face: json['face'] as String,
      sign: json['sign'] as String,
      attribute: (json['attribute'] as num).toInt(),
      officialVerify: json['official_verify'] == null
          ? null
          : OfficialVerify.fromJson(json['official_verify'] as Map<String, dynamic>),
      vip: json['vip'] == null
          ? null
          : VipInfo.fromJson(json['vip'] as Map<String, dynamic>),
      mtime: (json['mtime'] as num).toInt(),
      special: (json['special'] as num).toInt(),
    );
  }

  final int mid;
  final String uname;
  final String face;
  final String sign;
  final int attribute;
  final OfficialVerify? officialVerify;
  final VipInfo? vip;
  final int mtime;
  final int special;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ProfileRelationUser &&
            runtimeType == other.runtimeType &&
            mid == other.mid &&
            uname == other.uname &&
            face == other.face &&
            sign == other.sign &&
            attribute == other.attribute &&
            officialVerify == other.officialVerify &&
            vip == other.vip &&
            mtime == other.mtime &&
            special == other.special;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      mid,
      uname,
      face,
      sign,
      attribute,
      officialVerify,
      vip,
      mtime,
      special,
    );
  }

  @override
  String toString() {
    return 'ProfileRelationUser('
        'mid: $mid, '
        'uname: $uname, '
        'face: $face, '
        'sign: $sign, '
        'attribute: $attribute, '
        'officialVerify: $officialVerify, '
        'vip: $vip, '
        'mtime: $mtime, '
        'special: $special'
        ')';
  }
}
