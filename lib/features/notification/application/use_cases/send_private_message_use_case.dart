import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/notification/application/notification_repository_provider.dart';
import 'package:culcul/features/notification/domain/entities/private_message.dart';
import 'package:culcul/features/notification/domain/entities/send_message_result.dart';
import 'package:culcul/features/notification/domain/repositories/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'send_private_message_use_case.g.dart';

@riverpod
SendPrivateMessageUseCase sendPrivateMessageUseCase(Ref ref) {
  return SendPrivateMessageUseCase(
    ref.watch(notificationRepositoryEntryProvider),
  );
}

class SendPrivateMessageCommand {
  const SendPrivateMessageCommand({
    required this.ownerUid,
    required this.receiverId,
    required this.receiverType,
    required this.messageType,
    required this.content,
  });

  final int ownerUid;
  final int receiverId;
  final PrivateMessageReceiverType receiverType;
  final PrivateMessageType messageType;
  final PrivateMessageContent content;
}

class SendPrivateMessageUseCase {
  SendPrivateMessageUseCase(this._repository);

  final NotificationRepository _repository;

  Future<Result<SendMessageResult, AppError>> call(SendPrivateMessageCommand command) async {
    return _repository.sendPrivateMessage(
      ownerUid: command.ownerUid,
      receiverId: command.receiverId,
      receiverType: command.receiverType,
      messageType: command.messageType,
      content: command.content,
    );
  }
}
