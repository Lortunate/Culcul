import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class BilibiliEmojiText extends StatelessWidget {
  final String text;
  final Map emojiMap; // Can be Map<String, String> or Map<String, CommentEmote>
  final TextStyle? style;
  final double emojiSize;
  final bool selectable;
  final int? maxLines;
  final TextOverflow? overflow;
  final ValueChanged<String>? onEmojiTap; // Callback when an emoji is tapped (optional)

  const BilibiliEmojiText({
    super.key,
    required this.text,
    this.emojiMap = const {},
    this.style,
    this.emojiSize = 20.0,
    this.selectable = false,
    this.maxLines,
    this.overflow,
    this.onEmojiTap,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = DefaultTextStyle.of(context).style;
    final effectiveStyle = style ?? defaultStyle;

    final span = buildEmojiTextSpan(
      text: text,
      emojiMap: emojiMap,
      style: effectiveStyle,
      emojiSize: emojiSize,
      onEmojiTap: onEmojiTap,
    );

    if (selectable) {
      return SelectableText.rich(span, maxLines: maxLines);
    }
    return Text.rich(span, maxLines: maxLines, overflow: overflow);
  }

  static TextSpan buildEmojiTextSpan({
    required String text,
    required Map emojiMap,
    required TextStyle style,
    double emojiSize = 20.0,
    ValueChanged<String>? onEmojiTap,
  }) {
    if (emojiMap.isEmpty) {
      return TextSpan(text: text, style: style);
    }

    final spans = <InlineSpan>[];
    final regex = RegExp(r'(\[.*?\])');

    text.splitMapJoin(
      regex,
      onMatch: (Match m) {
        final matchText = m[0]!;
        String? url;

        // Handle different types of emoji map values
        final emojiData = emojiMap[matchText];
        if (emojiData is String) {
          url = emojiData;
        } else if (emojiData != null) {
          // Try to access 'url' property dynamically if it's an object (like CommentEmote)
          try {
            url = (emojiData as dynamic).url;
          } catch (e) {
            // Ignore
          }
        }

        if (url != null) {
          spans.add(
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: ExtendedImage.network(
                  url,
                  width: emojiSize,
                  height: emojiSize,
                  fit: BoxFit.contain,
                ),
              ),
              alignment: PlaceholderAlignment.middle,
            ),
          );
        } else {
          spans.add(TextSpan(text: matchText, style: style));
        }
        return '';
      },
      onNonMatch: (String s) {
        if (s.isNotEmpty) {
          spans.add(TextSpan(text: s, style: style));
        }
        return '';
      },
    );

    return TextSpan(children: spans);
  }
}
