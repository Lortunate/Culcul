import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ShowLoginDialog = void Function(BuildContext context);

/// Provides the login dialog action. Must be overridden at bootstrap.
final showLoginDialogProvider = Provider<ShowLoginDialog>((ref) {
  throw UnimplementedError('showLoginDialogProvider must be overridden at bootstrap');
});
