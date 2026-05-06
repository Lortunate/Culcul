import 'package:flutter/material.dart';

class AppMinLinesText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final int? minLines;
  final int? maxLines;
  final TextOverflow overflow;
  final TextAlign? textAlign;

  const AppMinLinesText(
    this.data, {
    super.key,
    this.style,
    this.minLines,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.textAlign,
  }) : assert(minLines == null || minLines > 0),
       assert(maxLines == null || maxLines > 0),
       assert(minLines == null || maxLines == null || maxLines >= minLines);

  @override
  Widget build(BuildContext context) {
    final effectiveMinLines = minLines;
    if (effectiveMinLines == null || effectiveMinLines <= 1) {
      return Text(
        data,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveStyle = DefaultTextStyle.of(context).style.merge(style);
        final textPainter = TextPainter(
          text: TextSpan(text: data, style: effectiveStyle),
          textDirection: Directionality.of(context),
          maxLines: maxLines,
        );

        final maxWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : double.infinity;
        textPainter.layout(maxWidth: maxWidth);

        final lineCount = textPainter.computeLineMetrics().length;
        final missingLines = effectiveMinLines - lineCount;
        final displayText = missingLines > 0 ? '$data${'\n' * missingLines}' : data;

        return Text(
          displayText,
          style: style,
          maxLines: maxLines,
          overflow: overflow,
          textAlign: textAlign,
        );
      },
    );
  }
}
