import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatPageCommandWorkflowProvider = Provider<ChatPageCommandWorkflow>(
  (ref) => const ChatPageCommandWorkflow(),
);

typedef ChatTextCommand = Future<ChatPageCommandResult> Function(String text);
typedef ChatImageCommand = Future<ChatPageCommandResult> Function(File image);
typedef ChatPostSuccessAction = Future<void> Function();
typedef ChatClearInputAction = void Function();

enum ChatPageCommandStatus { skipped, success, failure }

class ChatPageCommandResult {
  final ChatPageCommandStatus status;
  final Object? error;

  const ChatPageCommandResult._(this.status, [this.error]);

  const ChatPageCommandResult.skipped() : this._(ChatPageCommandStatus.skipped);

  const ChatPageCommandResult.success() : this._(ChatPageCommandStatus.success);

  const ChatPageCommandResult.failure(Object error)
    : this._(ChatPageCommandStatus.failure, error);

  bool get isSuccess => status == ChatPageCommandStatus.success;
  bool get isFailure => status == ChatPageCommandStatus.failure;
}

class ChatPageCommandWorkflow {
  const ChatPageCommandWorkflow();

  Future<ChatPageCommandResult> sendText({
    required String text,
    required ChatTextCommand send,
    required ChatClearInputAction clearInput,
    required ChatPostSuccessAction afterSuccess,
  }) async {
    if (text.trim().isEmpty) {
      return const ChatPageCommandResult.skipped();
    }

    try {
      final result = await send(text);
      if (!result.isSuccess) {
        return result;
      }
      clearInput();
      await afterSuccess();
      return const ChatPageCommandResult.success();
    } catch (error) {
      return ChatPageCommandResult.failure(error);
    }
  }

  Future<ChatPageCommandResult> sendImage({
    required File image,
    required ChatImageCommand send,
    required ChatPostSuccessAction afterSuccess,
  }) async {
    try {
      final result = await send(image);
      if (!result.isSuccess) {
        return result;
      }
      await afterSuccess();
      return const ChatPageCommandResult.success();
    } catch (error) {
      return ChatPageCommandResult.failure(error);
    }
  }
}
