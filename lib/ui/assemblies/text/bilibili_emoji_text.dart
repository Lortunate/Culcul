import 'package:culcul/ui/widgets/inputs/app_selectable_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class BilibiliEmojiText extends StatelessWidget {
  static final _emojiRegex = RegExp(r'(\[.*?\])');
  final String text;
  final Map emojiMap;
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
      return AppSelectableText.rich(span, maxLines: maxLines);
    }
    return Text.rich(span, maxLines: maxLines, overflow: overflow);
  }

  static String? _resolveEmojiUrl(dynamic emojiData) {
    if (emojiData is String) {
      return emojiData;
    }
    if (emojiData == null) {
      return null;
    }

    try {
      return (emojiData as dynamic).url as String?;
    } catch (_) {
      return null;
    }
  }

  static InlineSpan _buildEmojiSpan({
    required String url,
    required double emojiSize,
    required String matchText,
    ValueChanged<String>? onEmojiTap,
  }) {
    final image = ExtendedImage.network(
      url,
      width: emojiSize,
      height: emojiSize,
      fit: BoxFit.contain,
    );

    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: onEmojiTap == null
            ? image
            : GestureDetector(onTap: () => onEmojiTap(matchText), child: image),
      ),
    );
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

    text.splitMapJoin(
      _emojiRegex,
      onMatch: (Match m) {
        final matchText = m[0]!;
        final url = _resolveEmojiUrl(emojiMap[matchText]);

        if (url != null) {
          spans.add(
            _buildEmojiSpan(
              url: url,
              emojiSize: emojiSize,
              matchText: matchText,
              onEmojiTap: onEmojiTap,
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
