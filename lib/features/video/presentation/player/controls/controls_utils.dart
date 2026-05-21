import 'package:culcul/ui/theme/culcul_tokens.dart';
import 'package:flutter/material.dart';

bool isPlayerBottomSheetLayout(BuildContext context) =>
    MediaQuery.orientationOf(context) == Orientation.portrait;

void showSidePanel(BuildContext context, Widget child) {
  final isLandscape = !isPlayerBottomSheetLayout(context);

  if (isLandscape) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Selection',
      barrierColor: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.45),
      transitionDuration: CulculMotion.standard,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(alignment: Alignment.centerRight, child: child);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutQuart)),
          child: child,
        );
      },
    );
  } else {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => child,
    );
  }
}
