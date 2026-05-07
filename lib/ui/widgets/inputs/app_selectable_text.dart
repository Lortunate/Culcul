import 'package:flutter/material.dart';

class AppSelectableText extends StatelessWidget {
  final TextSpan textSpan;
  final int? maxLines;
  final TextAlign? textAlign;
  final ScrollPhysics scrollPhysics;

  AppSelectableText(
    String data, {
    super.key,
    TextStyle? style,
    this.maxLines,
    this.textAlign,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
  }) : textSpan = TextSpan(text: data, style: style);

  const AppSelectableText.rich(
    this.textSpan, {
    super.key,
    this.maxLines,
    this.textAlign,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
  });

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      textSpan,
      maxLines: maxLines,
      textAlign: textAlign,
      scrollPhysics: scrollPhysics,
    );
  }
}
