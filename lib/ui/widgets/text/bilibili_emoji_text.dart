import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class BilibiliEmojiText extends StatelessWidget {
  static final _emojiRegex = RegExp(r'(\[.*?\])');
  final String text;
  final Map<String, dynamic> emojiMap;
  final TextStyle? style;
  final double emojiSize;
  final bool selectable;
  final int? maxLines;
  final TextOverflow? overflow;
  final ValueChanged<String>? onEmojiTap;

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
    final span = buildEmojiTextSpan(
      text: text,
      emojiMap: emojiMap,
      style: style ?? DefaultTextStyle.of(context).style,
      emojiSize: emojiSize,
      onEmojiTap: onEmojiTap,
    );

    if (selectable) {
      return SelectableText.rich(
        span,
        maxLines: maxLines,
        scrollPhysics: const NeverScrollableScrollPhysics(),
      );
    }
    return Text.rich(span, maxLines: maxLines, overflow: overflow);
  }

  static TextSpan buildEmojiTextSpan({
    required String text,
    required Map<String, dynamic> emojiMap,
    required TextStyle style,
    double emojiSize = 20.0,
    ValueChanged<String>? onEmojiTap,
  }) {
    if (emojiMap.isEmpty) {
      return TextSpan(text: text, style: style);
    }

    final spans = <InlineSpan>[];

    text.splitMapJoin(
      _emojiRegex,
      onMatch: (Match m) {
        final matchText = m[0]!;
        final emojiData = emojiMap[matchText];
        final String? url = switch (emojiData) {
          final String value => value,
          final Map<String, dynamic> value => value['url'] as String?,
          _ => null,
        };

        if (url != null) {
          final image = ExtendedImage.network(
            url,
            width: emojiSize,
            height: emojiSize,
            fit: BoxFit.contain,
          );

          spans.add(
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: onEmojiTap == null
                    ? image
                    : GestureDetector(onTap: () => onEmojiTap(matchText), child: image),
              ),
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
