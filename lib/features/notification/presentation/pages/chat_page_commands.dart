import 'dart:io';

import 'package:culcul/features/notification/presentation/view_models/chat_view_model.dart';
import 'package:culcul/i18n/i18n.dart';
import 'package:flutter/material.dart';

class ChatPageCommands {
  ChatPageCommands({
    required this.textController,
    required this.sendMessage,
    required this.sendImage,
    required this.scrollToBottom,
    required this.showSendError,
  });

  factory ChatPageCommands.fromPage({
    required BuildContext context,
    required Chat notifier,
    required ScrollController scrollController,
    required TextEditingController textController,
  }) {
    final t = i18n(context);

    Future<void> scroll() async {
      if (!scrollController.hasClients) {
        return;
      }
      await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    void showError(String message) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    return ChatPageCommands(
      textController: textController,
      sendMessage: notifier.sendMessage,
      sendImage: notifier.sendImage,
      scrollToBottom: scroll,
      showSendError: (error) {
        showError(t.notification.chat.send_failed(error: error));
      },
    );
  }

  final TextEditingController textController;
  final Future<void> Function(String text) sendMessage;
  final Future<void> Function(File image) sendImage;
  final Future<void> Function() scrollToBottom;
  final void Function(String message) showSendError;

  Future<void> sendText(String text) async {
    try {
      await sendMessage(text);
      textController.clear();
      await scrollToBottom();
    } catch (e) {
      showSendError(e.toString());
    }
  }

  Future<void> sendImageFile(File image) async {
    try {
      await sendImage(image);
      await scrollToBottom();
    } catch (e) {
      showSendError(e.toString());
    }
  }
}
