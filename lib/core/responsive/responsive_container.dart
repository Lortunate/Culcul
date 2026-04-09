import 'package:culcul/core/responsive/app_responsive.dart';
import 'package:flutter/widgets.dart';

class ResponsiveContentContainer extends StatelessWidget {
  const ResponsiveContentContainer({
    super.key,
    required this.child,
    required this.maxWidth,
    this.alignment = Alignment.topCenter,
    this.horizontalPadding,
  });

  final Widget child;
  final double maxWidth;
  final AlignmentGeometry alignment;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final padding = horizontalPadding ?? context.pageHorizontalPadding;

    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
