import 'package:culcul/ui/assemblies/text/bilibili_emoji_text.dart';
import 'package:flutter/material.dart';

class ChatTextMessage extends StatelessWidget {
  final String text;
  final Map<String, String> emojiMap;
  final Color textColor;

  const ChatTextMessage({
    super.key,
    required this.text,
    required this.emojiMap,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return BilibiliEmojiText(
      text: text,
      emojiMap: emojiMap,
      style: TextStyle(color: textColor, fontSize: 16, height: 1.3),
      selectable: true,
      emojiSize: 24,
    );
  }
}
