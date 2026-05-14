import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:culcul/features/notification/domain/entities/private_message.dart';

part 'private_session.freezed.dart';

enum PrivateSessionType {
  unknown(0),
  user(1),
  group(2),
  system(7);

  const PrivateSessionType(this.value);

  final int value;

  static PrivateSessionType fromValue(int value) {
    return values.firstWhere(
      (type) => type.value == value,
      orElse: () => PrivateSessionType.unknown,
    );
  }

  PrivateMessageReceiverType get receiverType {
    return switch (this) {
      PrivateSessionType.group => PrivateMessageReceiverType.group,
      _ => PrivateMessageReceiverType.user,
    };
  }
}

@freezed
sealed class PrivateSessionAccountInfo with _$PrivateSessionAccountInfo {
  const factory PrivateSessionAccountInfo({
    required String name,
    required String picUrl,
  }) = _PrivateSessionAccountInfo;
}

@freezed
sealed class PrivateSession with _$PrivateSession {
  const factory PrivateSession({
    required int talkerId,
    required PrivateSessionType sessionType,
    required int unreadCount,
    PrivateMessage? lastMessage,
    String? groupName,
    String? groupCover,
    required int isFollow,
    required int sessionTs,
    PrivateSessionAccountInfo? accountInfo,
  }) = _PrivateSession;
}
