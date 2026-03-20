import 'package:flutter/material.dart';

Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return showModalBottomSheet<T>(
    context: context,
    builder: builder,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    backgroundColor: colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    clipBehavior: Clip.antiAlias,
  );
}
