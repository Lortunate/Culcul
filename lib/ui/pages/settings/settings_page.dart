import 'package:culcul/providers/settings/settings_provider.dart';
import 'package:culcul/ui/pages/settings/widgets/settings_group.dart';
import 'package:culcul/ui/pages/settings/widgets/settings_item.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/index.dart';
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
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
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
            title: t.settings.language,
            children: [
              SettingsItem(
                title: t.settings.change_language,
                value: _getLanguageName(t, LocaleSettings.currentLocale),
                onTap: () => _showLanguageSelector(context),
              ),
            ],
          ),
          SettingsGroup(
            title: t.settings.appearance,
            children: [
              SettingsItem(
                title: t.settings.appearance,
                value: _getThemeName(t, themeMode),
                onTap: () => _showThemeSelector(context, ref, themeMode),
              ),
            ],
          ),
          SettingsGroup(
            title: t.settings.cache,
            children: [
              SettingsItem(
                title: t.settings.clear_cache,
                value: cacheSizeAsync.when(
                  data: (size) => size,
                  loading: () => '...',
                  error: (_, __) => '0 B',
                ),
                onTap: () => _handleClearCache(context, ref),
              ),
            ],
          ),
          SettingsGroup(
            title: t.settings.about,
            children: [
              SettingsItem(title: t.settings.user_agreement, onTap: () {}),
              SettingsItem(title: t.settings.privacy_policy, onTap: () {}),
              SettingsItem(
                title: t.settings.version,
                value: 'v1.0.0',
                showArrow: false,
              ),
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
      case AppLocale.en:
        return t.settings.english;
    }
  }

  String _getThemeName(Translations t, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return t.settings.system_mode;
      case ThemeMode.light:
        return t.settings.light_mode;
      case ThemeMode.dark:
        return t.settings.dark_mode;
    }
  }

  void _showLanguageSelector(BuildContext context) {
    final t = Translations.of(context);
    _showSelectionSheet(
      context,
      title: t.settings.change_language,
      children: AppLocale.values.map((locale) {
        return _SelectionItem(
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

  void _showThemeSelector(
    BuildContext context,
    WidgetRef ref,
    ThemeMode currentMode,
  ) {
    final t = Translations.of(context);
    _showSelectionSheet(
      context,
      title: t.settings.appearance,
      children: ThemeMode.values.map((mode) {
        return _SelectionItem(
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
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...children,
              const SizedBox(height: 12),
            ],
          ),
        );
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

class _SelectionItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected)
              Icon(Icons.check_rounded, color: colorScheme.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
