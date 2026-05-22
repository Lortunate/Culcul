import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/settings/application/settings_controller.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_group.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_selection_item.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_selection_sheet.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_tile.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'settings_page.scaffold.dart';

class SettingsPage extends ConsumerWidget {
  final VoidCallback onOpenAbout;

  const SettingsPage({required this.onOpenAbout, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _SettingsPageScaffold(onOpenAbout: onOpenAbout);
  }
}
