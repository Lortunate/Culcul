import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message_result.freezed.dart';

@freezed
sealed class SendMessageResult with _$SendMessageResult {
  const factory SendMessageResult({
    required int msgKey,
    String? msgContent,
    Map<String, dynamic>? keyHitInfos,
  }) = _SendMessageResult;
}
