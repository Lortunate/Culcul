import 'dart:io';

import 'package:culcul/features/notification/presentation/pages/chat_page_commands.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatPageCommands', () {
    test('sendText clears input and scrolls after successful send', () async {
      final sent = <String>[];
      var scrolled = 0;
      final controller = TextEditingController(text: 'hello');
      final commands = ChatPageCommands(
        textController: controller,
        sendMessage: (text) async {
          sent.add(text);
        },
        sendImage: (_) async {},
        scrollToBottom: () async {
          scrolled++;
        },
        showSendError: (_) {},
      );

      await commands.sendText('hello');

      expect(sent, ['hello']);
      expect(controller.text, isEmpty);
      expect(scrolled, 1);
    });

    test('sendText reports failures without clearing input', () async {
      final errors = <String>[];
      final controller = TextEditingController(text: 'hello');
      final commands = ChatPageCommands(
        textController: controller,
        sendMessage: (_) async {
          throw Exception('boom');
        },
        sendImage: (_) async {},
        scrollToBottom: () async {},
        showSendError: errors.add,
      );

      await commands.sendText('hello');

      expect(controller.text, 'hello');
      expect(errors.single, contains('boom'));
    });

    test('sendImage scrolls on success', () async {
      final sent = <File>[];
      var scrolled = 0;
      final image = File('fake.png');
      final commands = ChatPageCommands(
        textController: TextEditingController(),
        sendMessage: (_) async {},
        sendImage: (file) async {
          sent.add(file);
        },
        scrollToBottom: () async {
          scrolled++;
        },
        showSendError: (_) {},
      );

      await commands.sendImageFile(image);

      expect(sent, [image]);
      expect(scrolled, 1);
    });
  });
}
