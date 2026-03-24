import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/settings/controllers/settings_controller.dart';
import 'package:culcul/features/settings/presentation/widgets/selection_sheet/selection_item.dart';
import 'package:culcul/features/settings/presentation/widgets/selection_sheet/selection_sheet.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_group.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TranslationProvider.of(context);
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final themeMode = ref.watch(themeModeProvider);
    final cacheSizeAsync = ref.watch(cacheSizeProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          t.settings.title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        children: [
          SettingsGroup(
            title: t.settings.sections.general,
            children: [
              SettingsItem(
                title: t.settings.language,
                value: _getLanguageName(t, LocaleSettings.currentLocale),
                onTap: () => _showLanguageSelector(context),
              ),
            ],
          ),
          SettingsGroup(
            title: t.settings.sections.appearance,
            children: [
              SettingsItem(
                title: t.settings.appearance,
                value: _getThemeName(t, themeMode),
                onTap: () => _showThemeSelector(context, ref, themeMode),
              ),
            ],
          ),
          SettingsGroup(
            title: t.settings.sections.storage,
            children: [
              SettingsItem(
                title: t.settings.clear_cache,
                value: cacheSizeAsync.when(
                  data: (size) => size,
                  loading: () => '...',
                  error: (_, _) => '0 B',
                ),
                onTap: () => _handleClearCache(context, ref),
              ),
            ],
          ),
          SettingsGroup(
            title: t.settings.sections.about,
            children: [
              SettingsItem(title: t.settings.user_agreement, onTap: () {}),
              SettingsItem(title: t.settings.privacy_policy, onTap: () {}),
              SettingsItem(title: t.settings.version, value: 'v1.0.0', showArrow: false),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  String _getLanguageName(Translations t, AppLocale locale) {
    switch (locale) {
      case AppLocale.zh:
        return t.settings.chinese;
      case AppLocale.zhHant:
        return t.settings.traditional_chinese;
      case AppLocale.en:
        return t.settings.english;
    }
  }

  String _getThemeName(Translations t, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return t.settings.theme_mode.system;
      case ThemeMode.light:
        return t.settings.theme_mode.light;
      case ThemeMode.dark:
        return t.settings.theme_mode.dark;
    }
  }

  void _showLanguageSelector(BuildContext context) {
    final t = Translations.of(context);
    _showSelectionSheet(
      context,
      title: t.settings.language,
      children: AppLocale.values.map((locale) {
        return SelectionItem(
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
        return SelectionItem(
          title: _getThemeName(t, mode),
          isSelected: currentMode == mode,
          onTap: () {
            ref.read(themeModeProvider.notifier).setTheme(mode);
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SelectionSheet(title: title, children: children);
      },
    );
  }

  Future<void> _handleClearCache(BuildContext context, WidgetRef ref) async {
    final t = Translations.of(context);
    await ref.read(clearCacheProvider)();
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
