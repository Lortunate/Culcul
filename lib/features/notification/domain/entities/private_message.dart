import 'dart:convert';
import 'package:culcul/features/notification/data/dtos/private_message_model.dart'
    show PrivateMessageEmojiInfo;

part 'private_message.types.dart';

class PrivateMessage {
  final int senderUid;
  final PrivateMessageReceiverType receiverType;
  final int receiverId;
  final PrivateMessageType type;
  final PrivateMessageContent content;
  final int msgSeqno;
  final int timestamp;
  final List<int>? atUids;
  final int? msgKey;
  final int? msgStatus;
  final String? notifyCode;
  final int? newFaceVersion;
  final int? msgSource;

  const PrivateMessage({
    required this.senderUid,
    required this.receiverType,
    required this.receiverId,
    required this.type,
    required this.content,
    required this.msgSeqno,
    required this.timestamp,
    required this.atUids,
    required this.msgKey,
    required this.msgStatus,
    required this.notifyCode,
    required this.newFaceVersion,
    required this.msgSource,
  });

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
