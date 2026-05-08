import 'dart:io';

import 'package:culcul/features/notification/presentation/chat_page_commands.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatPageCommandWorkflow', () {
    const workflow = ChatPageCommandWorkflow();

    test('skips blank text without invoking callbacks', () async {
      var sent = false;
      var cleared = false;
      var scrolled = false;

      final result = await workflow.sendText(
        text: '   ',
        send: (_) async {
          sent = true;
          return const ChatPageCommandResult.success();
        },
        clearInput: () => cleared = true,
        afterSuccess: () async => scrolled = true,
      );

      expect(result.status, ChatPageCommandStatus.skipped);
      expect(sent, isFalse);
      expect(cleared, isFalse);
      expect(scrolled, isFalse);
    });

    test('clears input and triggers follow-up after successful text send', () async {
      final calls = <String>[];

      final result = await workflow.sendText(
        text: 'hello',
        send: (text) async {
          calls.add('send:$text');
          return const ChatPageCommandResult.success();
        },
        clearInput: () => calls.add('clear'),
        afterSuccess: () async => calls.add('after'),
      );

      expect(result.status, ChatPageCommandStatus.success);
      expect(calls, <String>['send:hello', 'clear', 'after']);
    });

    test('preserves input side effects when text send fails', () async {
      var cleared = false;
      var followedUp = false;

      final result = await workflow.sendText(
        text: 'hello',
        send: (_) async => throw StateError('send failed'),
        clearInput: () => cleared = true,
        afterSuccess: () async => followedUp = true,
      );

      expect(result.status, ChatPageCommandStatus.failure);
      expect(result.error, isA<StateError>());
      expect(cleared, isFalse);
      expect(followedUp, isFalse);
    });

    test('does not clear input when send returns a failure result', () async {
      var cleared = false;
      var followedUp = false;

      final result = await workflow.sendText(
        text: 'hello',
        send: (_) async => ChatPageCommandResult.failure(StateError('send failed')),
        clearInput: () => cleared = true,
        afterSuccess: () async => followedUp = true,
      );

      expect(result.status, ChatPageCommandStatus.failure);
      expect(result.error, isA<StateError>());
      expect(cleared, isFalse);
      expect(followedUp, isFalse);
    });

    test('runs image follow-up only after successful send', () async {
      final calls = <String>[];

      final result = await workflow.sendImage(
        image: File('demo.png'),
        send: (image) async {
          calls.add(image.path);
          return const ChatPageCommandResult.success();
        },
        afterSuccess: () async => calls.add('after'),
      );

      expect(result.status, ChatPageCommandStatus.success);
      expect(calls, <String>['demo.png', 'after']);
    });

    test('skips image follow-up when send returns a failure result', () async {
      var followedUp = false;

      final result = await workflow.sendImage(
        image: File('demo.png'),
        send: (_) async => ChatPageCommandResult.failure(StateError('upload failed')),
        afterSuccess: () async => followedUp = true,
      );

      expect(result.status, ChatPageCommandStatus.failure);
      expect(result.error, isA<StateError>());
      expect(followedUp, isFalse);
    });
  });
}
