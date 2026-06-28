import 'package:culcul/features/notification/models/notification_entry.dart';
import 'package:flutter/foundation.dart';

final class ReplyResponse {
  ReplyResponse({required this.cursor, List<ReplyItem> items = const <ReplyItem>[]})
    : _items = List<ReplyItem>.unmodifiable(items);

  factory ReplyResponse.fromJson(Map<String, dynamic> json) {
    return ReplyResponse(
      cursor: ReplyCursor.fromJson(json['cursor'] as Map<String, dynamic>),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ReplyItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ReplyItem>[],
    );
  }

  final ReplyCursor cursor;
  final List<ReplyItem> _items;

  List<ReplyItem> get items => _items;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ReplyResponse &&
            runtimeType == other.runtimeType &&
            cursor == other.cursor &&
            listEquals(_items, other._items);
  }

  @override
  int get hashCode => Object.hash(runtimeType, cursor, Object.hashAll(_items));

  @override
  String toString() => 'ReplyResponse(cursor: $cursor, items: $_items)';
}

final class ReplyCursor {
  const ReplyCursor({required this.isEnd, required this.id, required this.time});

  factory ReplyCursor.fromJson(Map<String, dynamic> json) {
    return ReplyCursor(
      isEnd: json['is_end'] as bool,
      id: (json['id'] as num).toInt(),
      time: (json['time'] as num).toInt(),
    );
  }

  final bool isEnd;
  final int id;
  final int time;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ReplyCursor &&
            runtimeType == other.runtimeType &&
            isEnd == other.isEnd &&
            id == other.id &&
            time == other.time;
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEnd, id, time);

  @override
  String toString() => 'ReplyCursor(isEnd: $isEnd, id: $id, time: $time)';
}

final class ReplyItem {
  ReplyItem({
    required this.id,
    List<NotificationActor>? users,
    this.user,
    required this.item,
    this.replyTime,
    this.likeTime,
  }) : _users = users == null ? null : List<NotificationActor>.unmodifiable(users);

  factory ReplyItem.fromJson(Map<String, dynamic> json) {
    return ReplyItem(
      id: (json['id'] as num).toInt(),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => NotificationActor.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : NotificationActor.fromJson(json['user'] as Map<String, dynamic>),
      item: ReplyItemDetail.fromJson(json['item'] as Map<String, dynamic>),
      replyTime: (json['reply_time'] as num?)?.toInt(),
      likeTime: (json['like_time'] as num?)?.toInt(),
    );
  }

  final int id;
  final List<NotificationActor>? _users;
  final NotificationActor? user;
  final ReplyItemDetail item;
  final int? replyTime;
  final int? likeTime;

  List<NotificationActor>? get users => _users;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'users': _users?.map((actor) => actor.toJson()).toList(),
      'user': user?.toJson(),
      'item': item.toJson(),
      'reply_time': replyTime,
      'like_time': likeTime,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ReplyItem &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            listEquals(_users, other._users) &&
            user == other.user &&
            item == other.item &&
            replyTime == other.replyTime &&
            likeTime == other.likeTime;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      id,
      Object.hashAll(_users ?? const <NotificationActor>[]),
      user,
      item,
      replyTime,
      likeTime,
    );
  }

  @override
  String toString() {
    return 'ReplyItem('
        'id: $id, '
        'users: $_users, '
        'user: $user, '
        'item: $item, '
        'replyTime: $replyTime, '
        'likeTime: $likeTime'
        ')';
  }
}

final class ReplyItemDetail {
  ReplyItemDetail({
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

  factory ReplyItemDetail.fromJson(Map<String, dynamic> json) {
    return ReplyItemDetail(
      subjectId: ((json['subject_id'] ?? json['item_id'] ?? 0) as num).toInt(),
      rootId: (json['root_id'] as num?)?.toInt() ?? 0,
      sourceId: (json['source_id'] as num?)?.toInt() ?? 0,
      targetId: (json['target_id'] as num?)?.toInt() ?? 0,
      type: json['type'] as String,
      businessId: (json['business_id'] as num?)?.toInt() ?? 0,
      business: json['business'] as String,
      title: json['title'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      image: json['image'] as String? ?? '',
      uri: json['uri'] as String? ?? '',
      nativeUri: json['native_uri'] as String? ?? '',
      rootReplyContent: json['root_reply_content'] as String? ?? '',
      sourceContent: json['source_content'] as String? ?? '',
      targetReplyContent: json['target_reply_content'] as String? ?? '',
      atDetails:
          (json['at_details'] as List<dynamic>?)
              ?.map((e) => NotificationActor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NotificationActor>[],
      hideReplyButton: json['hide_reply_button'] as bool? ?? false,
      hideLikeButton: json['hide_like_button'] as bool? ?? false,
      likeState: (json['like_state'] as num?)?.toInt() ?? 0,
      message: json['message'] as String? ?? '',
    );
  }

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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'subject_id': subjectId,
      'root_id': rootId,
      'source_id': sourceId,
      'target_id': targetId,
      'type': type,
      'business_id': businessId,
      'business': business,
      'title': title,
      'desc': desc,
      'image': image,
      'uri': uri,
      'native_uri': nativeUri,
      'root_reply_content': rootReplyContent,
      'source_content': sourceContent,
      'target_reply_content': targetReplyContent,
      'at_details': _atDetails.map((actor) => actor.toJson()).toList(),
      'hide_reply_button': hideReplyButton,
      'hide_like_button': hideLikeButton,
      'like_state': likeState,
      'message': message,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ReplyItemDetail &&
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
    return 'ReplyItemDetail('
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
