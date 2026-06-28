part of 'comment_contract.dart';

final class CommentLabel {
  const CommentLabel({
    required this.path,
    required this.text,
    required this.labelTheme,
    this.textColor = '',
    this.bgStyle = 0,
    this.bgColor = '',
    this.borderColor = '',
    this.useImgLabel = false,
    this.imgLabelUriHans = '',
    this.imgLabelUriHant = '',
    this.imgLabelUriHansStatic = '',
    this.imgLabelUriHantStatic = '',
  });

  factory CommentLabel.fromJson(Map<String, dynamic> json) {
    return CommentLabel(
      path: json['path'] as String,
      text: json['text'] as String,
      labelTheme: json['label_theme'] as String,
      textColor: json['text_color'] as String? ?? '',
      bgStyle: (json['bg_style'] as num?)?.toInt() ?? 0,
      bgColor: json['bg_color'] as String? ?? '',
      borderColor: json['border_color'] as String? ?? '',
      useImgLabel: json['use_img_label'] as bool? ?? false,
      imgLabelUriHans: json['img_label_uri_hans'] as String? ?? '',
      imgLabelUriHant: json['img_label_uri_hant'] as String? ?? '',
      imgLabelUriHansStatic: json['img_label_uri_hans_static'] as String? ?? '',
      imgLabelUriHantStatic: json['img_label_uri_hant_static'] as String? ?? '',
    );
  }

  final String path;
  final String text;
  final String labelTheme;
  final String textColor;
  final int bgStyle;
  final String bgColor;
  final String borderColor;
  final bool useImgLabel;
  final String imgLabelUriHans;
  final String imgLabelUriHant;
  final String imgLabelUriHansStatic;
  final String imgLabelUriHantStatic;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CommentLabel &&
            other.path == path &&
            other.text == text &&
            other.labelTheme == labelTheme &&
            other.textColor == textColor &&
            other.bgStyle == bgStyle &&
            other.bgColor == bgColor &&
            other.borderColor == borderColor &&
            other.useImgLabel == useImgLabel &&
            other.imgLabelUriHans == imgLabelUriHans &&
            other.imgLabelUriHant == imgLabelUriHant &&
            other.imgLabelUriHansStatic == imgLabelUriHansStatic &&
            other.imgLabelUriHantStatic == imgLabelUriHantStatic;
  }

  @override
  int get hashCode {
    return Object.hash(
      path,
      text,
      labelTheme,
      textColor,
      bgStyle,
      bgColor,
      borderColor,
      useImgLabel,
      imgLabelUriHans,
      imgLabelUriHant,
      imgLabelUriHansStatic,
      imgLabelUriHantStatic,
    );
  }

  @override
  String toString() {
    return 'CommentLabel('
        'path: $path, '
        'text: $text, '
        'labelTheme: $labelTheme, '
        'textColor: $textColor, '
        'bgStyle: $bgStyle, '
        'bgColor: $bgColor, '
        'borderColor: $borderColor, '
        'useImgLabel: $useImgLabel, '
        'imgLabelUriHans: $imgLabelUriHans, '
        'imgLabelUriHant: $imgLabelUriHant, '
        'imgLabelUriHansStatic: $imgLabelUriHansStatic, '
        'imgLabelUriHantStatic: $imgLabelUriHantStatic'
        ')';
  }
}

final class CommentContent {
  CommentContent({
    required this.message,
    this.plat = 0,
    this.device = '',
    List<CommentMember> members = const [],
    Map<String, CommentEmote>? emote,
    List<CommentPicture> pictures = const [],
    Map<String, dynamic> jumpUrl = const {},
    this.maxLine = 0,
  }) : members = List<CommentMember>.unmodifiable(members),
       emote = emote == null ? null : Map<String, CommentEmote>.unmodifiable(emote),
       pictures = List<CommentPicture>.unmodifiable(pictures),
       jumpUrl = Map<String, dynamic>.unmodifiable(jumpUrl);

  factory CommentContent.fromJson(Map<String, dynamic> json) {
    return CommentContent(
      message: json['message'] as String,
      plat: (json['plat'] as num?)?.toInt() ?? 0,
      device: json['device'] as String? ?? '',
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => CommentMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      emote: (json['emote'] as Map<String, dynamic>?)?.map(
        (key, value) =>
            MapEntry(key, CommentEmote.fromJson(value as Map<String, dynamic>)),
      ),
      pictures:
          (json['pictures'] as List<dynamic>?)
              ?.map((e) => CommentPicture.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      jumpUrl: json['jump_url'] as Map<String, dynamic>? ?? const {},
      maxLine: (json['max_line'] as num?)?.toInt() ?? 0,
    );
  }

  final String message;
  final int plat;
  final String device;
  final List<CommentMember> members;
  final Map<String, CommentEmote>? emote;
  final List<CommentPicture> pictures;
  final Map<String, dynamic> jumpUrl;
  final int maxLine;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CommentContent &&
            other.message == message &&
            other.plat == plat &&
            other.device == device &&
            const DeepCollectionEquality().equals(other.members, members) &&
            const DeepCollectionEquality().equals(other.emote, emote) &&
            const DeepCollectionEquality().equals(other.pictures, pictures) &&
            const DeepCollectionEquality().equals(other.jumpUrl, jumpUrl) &&
            other.maxLine == maxLine;
  }

  @override
  int get hashCode {
    return Object.hash(
      message,
      plat,
      device,
      const DeepCollectionEquality().hash(members),
      const DeepCollectionEquality().hash(emote),
      const DeepCollectionEquality().hash(pictures),
      const DeepCollectionEquality().hash(jumpUrl),
      maxLine,
    );
  }

  @override
  String toString() {
    return 'CommentContent('
        'message: $message, '
        'plat: $plat, '
        'device: $device, '
        'members: $members, '
        'emote: $emote, '
        'pictures: $pictures, '
        'jumpUrl: $jumpUrl, '
        'maxLine: $maxLine'
        ')';
  }
}

final class CommentPicture {
  const CommentPicture({
    required this.imgSrc,
    this.imgWidth = 0,
    this.imgHeight = 0,
    this.imgSize = 0,
  });

  factory CommentPicture.fromJson(Map<String, dynamic> json) {
    return CommentPicture(
      imgSrc: json['img_src'] as String,
      imgWidth: (json['img_width'] as num?)?.toDouble() ?? 0,
      imgHeight: (json['img_height'] as num?)?.toDouble() ?? 0,
      imgSize: (json['img_size'] as num?)?.toDouble() ?? 0,
    );
  }

  final String imgSrc;
  final double imgWidth;
  final double imgHeight;
  final double imgSize;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CommentPicture &&
            other.imgSrc == imgSrc &&
            other.imgWidth == imgWidth &&
            other.imgHeight == imgHeight &&
            other.imgSize == imgSize;
  }

  @override
  int get hashCode => Object.hash(imgSrc, imgWidth, imgHeight, imgSize);

  @override
  String toString() {
    return 'CommentPicture('
        'imgSrc: $imgSrc, '
        'imgWidth: $imgWidth, '
        'imgHeight: $imgHeight, '
        'imgSize: $imgSize'
        ')';
  }
}

final class CommentEmote {
  const CommentEmote({
    required this.id,
    this.packageId = 0,
    this.state = 0,
    this.type = 0,
    this.attr = 0,
    required this.text,
    required this.url,
    this.mtime = 0,
    this.jumpTitle = '',
  });

  factory CommentEmote.fromJson(Map<String, dynamic> json) {
    return CommentEmote(
      id: (json['id'] as num).toInt(),
      packageId: (json['package_id'] as num?)?.toInt() ?? 0,
      state: (json['state'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      attr: (json['attr'] as num?)?.toInt() ?? 0,
      text: json['text'] as String,
      url: json['url'] as String,
      mtime: (json['mtime'] as num?)?.toInt() ?? 0,
      jumpTitle: json['jump_title'] as String? ?? '',
    );
  }

  final int id;
  final int packageId;
  final int state;
  final int type;
  final int attr;
  final String text;
  final String url;
  final int mtime;
  final String jumpTitle;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CommentEmote &&
            other.id == id &&
            other.packageId == packageId &&
            other.state == state &&
            other.type == type &&
            other.attr == attr &&
            other.text == text &&
            other.url == url &&
            other.mtime == mtime &&
            other.jumpTitle == jumpTitle;
  }

  @override
  int get hashCode {
    return Object.hash(id, packageId, state, type, attr, text, url, mtime, jumpTitle);
  }

  @override
  String toString() {
    return 'CommentEmote('
        'id: $id, '
        'packageId: $packageId, '
        'state: $state, '
        'type: $type, '
        'attr: $attr, '
        'text: $text, '
        'url: $url, '
        'mtime: $mtime, '
        'jumpTitle: $jumpTitle'
        ')';
  }
}
