import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'private_message.types.dart';
part 'private_message.freezed.dart';

@freezed
sealed class PrivateMessage with _$PrivateMessage {
  const PrivateMessage._();

  const factory PrivateMessage({
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
  }) = _PrivateMessage;

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
}
