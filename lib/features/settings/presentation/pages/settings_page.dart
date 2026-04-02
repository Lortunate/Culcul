import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/features/settings/presentation/view_models/settings_view_model.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_group.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_selection_item.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_selection_sheet.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_tile.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TranslationProvider.of(context);
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final themeMode = ref.watch(appThemeModeProvider);
    final cacheSize = switch (ref.watch(cacheSizeProvider)) {
      AsyncData(:final value) => value,
      AsyncError() => '0 B',
      _ => '...',
    };
    final isClearingCache = ref.watch(cacheMaintenanceProvider).isLoading;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: _SettingsAppBar(title: t.settings.title),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: <Widget>[
          SettingsGroup(
            children: [
              SettingsTile(
                key: const ValueKey<String>('settings_row_appearance'),
                title: t.settings.appearance,
                icon: Icons.palette_outlined,
                value: _getThemeName(t, themeMode),
                onTap: () => _showThemeSelector(context, ref, themeMode),
              ),
              SettingsTile(
                key: const ValueKey<String>('settings_row_language'),
                title: t.settings.language,
                icon: Icons.language_outlined,
                value: _getLanguageName(t, LocaleSettings.currentLocale),
                onTap: () => _showLanguageSelector(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SettingsGroup(
            children: [
              SettingsTile(
                key: const ValueKey<String>('settings_row_cache'),
                title: t.settings.clear_cache,
                icon: Icons.cleaning_services_outlined,
                value: isClearingCache ? '...' : cacheSize,
                onTap: () => _handleClearCache(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SettingsGroup(
            children: [
              SettingsTile(
                key: const ValueKey<String>('settings_row_version'),
                title: t.settings.sections.about,
                icon: Icons.info_outline_rounded,
                onTap: () => const AboutRoute().push(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String _getLanguageName(Translations t, AppLocale locale) {
    return switch (locale) {
      AppLocale.zh => t.settings.chinese,
      AppLocale.zhHant => t.settings.traditional_chinese,
      AppLocale.en => t.settings.english,
    };
  }

  String _getThemeName(Translations t, ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => t.settings.theme_mode.system,
      ThemeMode.light => t.settings.theme_mode.light,
      ThemeMode.dark => t.settings.theme_mode.dark,
    };
  }

  void _showLanguageSelector(BuildContext context) {
    final t = Translations.of(context);
    _showSelectionSheet(
      context,
      title: t.settings.language,
      children: AppLocale.values.map((locale) {
        return SettingsSelectionItem(
          title: _getLanguageName(t, locale),
          isSelected: LocaleSettings.currentLocale == locale,
          onTap: () {
            LocaleSettings.setLocale(locale);
            context.pop();
          },
        );
      }).toList(),
    );
  }

  void _showThemeSelector(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    final t = Translations.of(context);
    _showSelectionSheet(
      context,
      title: t.settings.sections.appearance,
      children: ThemeMode.values.map((mode) {
        return SettingsSelectionItem(
          title: _getThemeName(t, mode),
          isSelected: currentMode == mode,
          onTap: () {
            ref.read(appThemeModeProvider.notifier).setTheme(mode);
            context.pop();
          },
        );
      }).toList(),
    );
  }

  void _showSelectionSheet(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SettingsSelectionSheet(title: title, children: children),
    );
  }

  Future<void> _handleClearCache(BuildContext context, WidgetRef ref) async {
    final t = Translations.of(context);
    await ref.read(cacheMaintenanceProvider.notifier).clear();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.common.refresh_completed),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SettingsAppBar({required this.title});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: colorScheme.surfaceContainerLowest,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        onPressed: () => context.pop(),
      ),
    );
  }
}
