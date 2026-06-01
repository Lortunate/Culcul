import 'package:flutter/foundation.dart';

final class NotificationActor {
  const NotificationActor({
    required this.mid,
    this.fans = 0,
    required this.nickname,
    required this.avatar,
    this.midLink = '',
    this.follow = false,
  });

  factory NotificationActor.fromJson(Map<String, dynamic> json) {
    return NotificationActor(
      mid: (json['mid'] as num).toInt(),
      fans: (json['fans'] as num?)?.toInt() ?? 0,
      nickname: json['nickname'] as String,
      avatar: json['avatar'] as String,
      midLink: json['mid_link'] as String? ?? '',
      follow: json['follow'] as bool? ?? false,
    );
  }

  final int mid;
  final int fans;
  final String nickname;
  final String avatar;
  final String midLink;
  final bool follow;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mid': mid,
      'fans': fans,
      'nickname': nickname,
      'avatar': avatar,
      'mid_link': midLink,
      'follow': follow,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NotificationActor &&
            runtimeType == other.runtimeType &&
            mid == other.mid &&
            fans == other.fans &&
            nickname == other.nickname &&
            avatar == other.avatar &&
            midLink == other.midLink &&
            follow == other.follow;
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, mid, fans, nickname, avatar, midLink, follow);

  @override
  String toString() {
    return 'NotificationActor('
        'mid: $mid, '
        'fans: $fans, '
        'nickname: $nickname, '
        'avatar: $avatar, '
        'midLink: $midLink, '
        'follow: $follow'
        ')';
  }
}

final class NotificationEntryDetail {
  NotificationEntryDetail({
    required this.subjectId,
    this.rootId = 0,
    this.sourceId = 0,
    this.targetId = 0,
    required this.type,
    this.businessId = 0,
    required this.business,
    this.title = '',
    this.desc = '',
    this.image = '',
    this.uri = '',
    this.nativeUri = '',
    this.rootReplyContent = '',
    this.sourceContent = '',
    this.targetReplyContent = '',
    List<NotificationActor> atDetails = const <NotificationActor>[],
    this.hideReplyButton = false,
    this.hideLikeButton = false,
    this.likeState = 0,
    this.message = '',
  }) : _atDetails = List<NotificationActor>.unmodifiable(atDetails);

  final int subjectId;
  final int rootId;
  final int sourceId;
  final int targetId;
  final String type;
  final int businessId;
  final String business;
  final String title;
  final String desc;
  final String image;
  final String uri;
  final String nativeUri;
  final String rootReplyContent;
  final String sourceContent;
  final String targetReplyContent;
  final List<NotificationActor> _atDetails;
  final bool hideReplyButton;
  final bool hideLikeButton;
  final int likeState;
  final String message;

  List<NotificationActor> get atDetails => _atDetails;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NotificationEntryDetail &&
            runtimeType == other.runtimeType &&
            subjectId == other.subjectId &&
            rootId == other.rootId &&
            sourceId == other.sourceId &&
            targetId == other.targetId &&
            type == other.type &&
            businessId == other.businessId &&
            business == other.business &&
            title == other.title &&
            desc == other.desc &&
            image == other.image &&
            uri == other.uri &&
            nativeUri == other.nativeUri &&
            rootReplyContent == other.rootReplyContent &&
            sourceContent == other.sourceContent &&
            targetReplyContent == other.targetReplyContent &&
            listEquals(_atDetails, other._atDetails) &&
            hideReplyButton == other.hideReplyButton &&
            hideLikeButton == other.hideLikeButton &&
            likeState == other.likeState &&
            message == other.message;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      subjectId,
      rootId,
      sourceId,
      targetId,
      type,
      businessId,
      business,
      title,
      desc,
      image,
      uri,
      nativeUri,
      rootReplyContent,
      sourceContent,
      targetReplyContent,
      Object.hashAll(_atDetails),
      hideReplyButton,
      hideLikeButton,
      likeState,
      message,
    ]);
  }

  @override
  String toString() {
    return 'NotificationEntryDetail('
        'subjectId: $subjectId, '
        'rootId: $rootId, '
        'sourceId: $sourceId, '
        'targetId: $targetId, '
        'type: $type, '
        'businessId: $businessId, '
        'business: $business, '
        'title: $title, '
        'desc: $desc, '
        'image: $image, '
        'uri: $uri, '
        'nativeUri: $nativeUri, '
        'rootReplyContent: $rootReplyContent, '
        'sourceContent: $sourceContent, '
        'targetReplyContent: $targetReplyContent, '
        'atDetails: $_atDetails, '
        'hideReplyButton: $hideReplyButton, '
        'hideLikeButton: $hideLikeButton, '
        'likeState: $likeState, '
        'message: $message'
        ')';
  }
}

final class NotificationEntry {
  NotificationEntry({
    required this.id,
    required List<NotificationActor> actors,
    required this.detail,
    required this.replyTime,
    required this.likeTime,
  }) : _actors = List<NotificationActor>.unmodifiable(actors);

  final int id;
  final List<NotificationActor> _actors;
  final NotificationEntryDetail detail;
  final int? replyTime;
  final int? likeTime;

  List<NotificationActor> get actors => _actors;
  NotificationActor? get primaryActor => _actors.isEmpty ? null : _actors.first;
  int get eventTime => replyTime ?? likeTime ?? 0;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NotificationEntry &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            listEquals(_actors, other._actors) &&
            detail == other.detail &&
            replyTime == other.replyTime &&
            likeTime == other.likeTime;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      id,
      Object.hashAll(_actors),
      detail,
      replyTime,
      likeTime,
    );
  }

  @override
  String toString() {
    return 'NotificationEntry('
        'id: $id, '
        'actors: $_actors, '
        'detail: $detail, '
        'replyTime: $replyTime, '
        'likeTime: $likeTime'
        ')';
  }
}
