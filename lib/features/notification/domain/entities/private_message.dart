import 'dart:convert';

import 'package:flutter/foundation.dart';

part 'private_message.types.dart';

final class PrivateMessage {
  PrivateMessage({
    required int senderUid,
    required PrivateMessageReceiverType receiverType,
    required int receiverId,
    required PrivateMessageType type,
    required PrivateMessageContent content,
    required int msgSeqno,
    required int timestamp,
    List<int>? atUids,
    int? msgKey,
    int? msgStatus,
    String? notifyCode,
    int? newFaceVersion,
    int? msgSource,
  }) : this._(
         senderUid: senderUid,
         receiverType: receiverType,
         receiverId: receiverId,
         type: type,
         content: content,
         msgSeqno: msgSeqno,
         timestamp: timestamp,
         atUids: atUids == null ? null : List<int>.unmodifiable(atUids),
         msgKey: msgKey,
         msgStatus: msgStatus,
         notifyCode: notifyCode,
         newFaceVersion: newFaceVersion,
         msgSource: msgSource,
       );

  const PrivateMessage._({
    required this.senderUid,
    required this.receiverType,
    required this.receiverId,
    required this.type,
    required this.content,
    required this.msgSeqno,
    required this.timestamp,
    required List<int>? atUids,
    this.msgKey,
    this.msgStatus,
    this.notifyCode,
    this.newFaceVersion,
    this.msgSource,
  }) : _atUids = atUids;

  final int senderUid;
  final PrivateMessageReceiverType receiverType;
  final int receiverId;
  final PrivateMessageType type;
  final PrivateMessageContent content;
  final int msgSeqno;
  final int timestamp;
  final List<int>? _atUids;
  final int? msgKey;
  final int? msgStatus;
  final String? notifyCode;
  final int? newFaceVersion;
  final int? msgSource;

  List<int>? get atUids => _atUids;

  Map<String, dynamic>? get contentMap {
    final json = content.toRawMap();
    return json.isEmpty ? null : json;
  }

  bool isMe(int currentUid) => senderUid == currentUid;

  String? get primaryText => content.primaryText;

  String? get titleText => content.title;

  String get textContent {
    if (type == PrivateMessageType.text) {
      return content.primaryText ?? '';
    }
    return '';
  }

  String? get imageUrl {
    if (type.isImage) {
      return content.imageUrl;
    }
    return null;
  }

  List<String>? get systemTipTexts {
    if (type == PrivateMessageType.systemTip) {
      return content.systemTipTexts;
    }
    return null;
  }

  String? get linkUrl => content.linkUrl;

  String? get jumpText => content.jumpText;

  String? get fallbackSummaryText => content.fallbackText;

  bool get isWithdrawn => msgStatus == 1 || type == PrivateMessageType.withdrawn;

  PrivateMessageSummaryKind get summaryKind {
    if (isWithdrawn) {
      return PrivateMessageSummaryKind.withdrawn;
    }

    return switch (type) {
      PrivateMessageType.text => PrivateMessageSummaryKind.text,
      PrivateMessageType.image ||
      PrivateMessageType.imageVariant => PrivateMessageSummaryKind.image,
      PrivateMessageType.notice => PrivateMessageSummaryKind.notice,
      PrivateMessageType.video => PrivateMessageSummaryKind.video,
      PrivateMessageType.article => PrivateMessageSummaryKind.article,
      PrivateMessageType.card => PrivateMessageSummaryKind.card,
      PrivateMessageType.share => PrivateMessageSummaryKind.share,
      _ => PrivateMessageSummaryKind.unknown,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PrivateMessage &&
            runtimeType == other.runtimeType &&
            senderUid == other.senderUid &&
            receiverType == other.receiverType &&
            receiverId == other.receiverId &&
            type == other.type &&
            content == other.content &&
            msgSeqno == other.msgSeqno &&
            timestamp == other.timestamp &&
            listEquals(_atUids, other._atUids) &&
            msgKey == other.msgKey &&
            msgStatus == other.msgStatus &&
            notifyCode == other.notifyCode &&
            newFaceVersion == other.newFaceVersion &&
            msgSource == other.msgSource;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      senderUid,
      receiverType,
      receiverId,
      type,
      content,
      msgSeqno,
      timestamp,
      Object.hashAll(_atUids ?? const <int>[]),
      msgKey,
      msgStatus,
      notifyCode,
      newFaceVersion,
      msgSource,
    );
  }

  @override
  String toString() {
    return 'PrivateMessage('
        'senderUid: $senderUid, '
        'receiverType: $receiverType, '
        'receiverId: $receiverId, '
        'type: $type, '
        'content: $content, '
        'msgSeqno: $msgSeqno, '
        'timestamp: $timestamp, '
        'atUids: $_atUids, '
        'msgKey: $msgKey, '
        'msgStatus: $msgStatus, '
        'notifyCode: $notifyCode, '
        'newFaceVersion: $newFaceVersion, '
        'msgSource: $msgSource'
        ')';
  }
}
