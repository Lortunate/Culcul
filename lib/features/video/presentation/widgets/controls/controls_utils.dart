import 'package:flutter/material.dart';

void showSidePanel(BuildContext context, Widget child) {
  final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

  if (isLandscape) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Selection',
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 250),
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
