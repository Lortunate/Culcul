import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/features/settings/controllers/settings_controller.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_group.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_item.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_selection_item.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_selection_sheet.dart';
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
    final themeMode = ref.watch(themeModeProvider);
    final cacheSize = switch (ref.watch(cacheSizeProvider)) {
      AsyncData(:final value) => value,
      AsyncError() => '0 B',
      _ => '...',
    };

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: _SettingsAppBar(title: t.settings.title),
      body: ListView(
        children: <Widget>[
          _GeneralSettingsSection(
            title: t.settings.sections.general,
            languageTitle: t.settings.language,
            currentLanguage: _getLanguageName(t, LocaleSettings.currentLocale),
            onTapLanguage: () => _showLanguageSelector(context),
          ),
          _AppearanceSettingsSection(
            title: t.settings.sections.appearance,
            appearanceTitle: t.settings.appearance,
            currentTheme: _getThemeName(t, themeMode),
            onTapAppearance: () => _showThemeSelector(context, ref, themeMode),
          ),
          _StorageSettingsSection(
            title: t.settings.sections.storage,
            clearCacheTitle: t.settings.clear_cache,
            cacheSize: cacheSize,
            onTapClearCache: () => _handleClearCache(context, ref),
          ),
          _AboutSettingsSection(
            title: t.settings.sections.about,
            versionTitle: t.settings.version,
          ),
          const SizedBox(height: 32),
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
      builder: (context) => SettingsSelectionSheet(title: title, children: children),
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

class _SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const _SettingsAppBar({required this.title});

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
      backgroundColor: colorScheme.surface,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        onPressed: () => context.pop(),
      ),
    );
  }
}

class _GeneralSettingsSection extends StatelessWidget {
  final String title;
  final String languageTitle;
  final String currentLanguage;
  final VoidCallback onTapLanguage;

  const _GeneralSettingsSection({
    required this.title,
    required this.languageTitle,
    required this.currentLanguage,
    required this.onTapLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: title,
      children: [
        SettingsItem(title: languageTitle, value: currentLanguage, onTap: onTapLanguage),
      ],
    );
  }
}

class _AppearanceSettingsSection extends StatelessWidget {
  final String title;
  final String appearanceTitle;
  final String currentTheme;
  final VoidCallback onTapAppearance;

  const _AppearanceSettingsSection({
    required this.title,
    required this.appearanceTitle,
    required this.currentTheme,
    required this.onTapAppearance,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: title,
      children: [
        SettingsItem(title: appearanceTitle, value: currentTheme, onTap: onTapAppearance),
      ],
    );
  }
}

class _StorageSettingsSection extends StatelessWidget {
  final String title;
  final String clearCacheTitle;
  final String cacheSize;
  final VoidCallback onTapClearCache;

  const _StorageSettingsSection({
    required this.title,
    required this.clearCacheTitle,
    required this.cacheSize,
    required this.onTapClearCache,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: title,
      children: [
        SettingsItem(title: clearCacheTitle, value: cacheSize, onTap: onTapClearCache),
      ],
    );
  }
}

class _AboutSettingsSection extends StatelessWidget {
  final String title;
  final String versionTitle;

  const _AboutSettingsSection({
    required this.title,
    required this.versionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: title,
      children: [
        SettingsItem(title: versionTitle, value: 'v1.0.0', showArrow: false),
      ],
    );
  }
}
