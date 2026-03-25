import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> globalScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class ToastUtils {
  static void show(String message) {
    final state = globalScaffoldMessengerKey.currentState;
    if (state != null) {
      state.showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 2000),
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  static void showError(String message) {
    final state = globalScaffoldMessengerKey.currentState;
    if (state != null) {
      final colorScheme = Theme.of(state.context).colorScheme;
      state.showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(color: colorScheme.onError)),
          backgroundColor: colorScheme.error,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 3000),
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }
}

