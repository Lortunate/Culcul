import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class ToViewPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ToViewPageAppBar({super.key, required this.isLoggedIn, required this.onClearAll});

  final bool isLoggedIn;
  final VoidCallback onClearAll;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(t.watch_later.title),
      actions: [
        if (isLoggedIn)
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            onPressed: onClearAll,
          ),
      ],
    );
  }
}

