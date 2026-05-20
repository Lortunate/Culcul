part of 'settings_page.dart';

class _SettingsPageScaffold extends ConsumerWidget {
  const _SettingsPageScaffold();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final themeMode = ref.watch(appThemeModeProvider);
    final cacheState = ref.watch(cacheSizeProvider);
    final cacheSize = cacheState.when(
      data: (value) => value,
      loading: () => '...',
      error: (error, stackTrace) => '0 B',
    );
    final isClearingCache = ref.watch(cacheMaintenanceProvider).isLoading;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(
          t.settings.title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surfaceContainerLowest,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          SettingsGroup(
            children: [
              SettingsTile(
                key: const ValueKey('appearance'),
                title: t.settings.appearance,
                icon: Icons.palette_outlined,
                value: _getThemeName(t, themeMode),
                onTap: () => _showThemeSelector(context, ref, themeMode),
              ),
              SettingsTile(
                key: const ValueKey('language'),
                title: t.settings.language,
                icon: Icons.language_outlined,
                value: _getLanguageName(t, LocaleSettings.currentLocale),
                onTap: () => _showLanguageSelector(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsGroup(
            children: [
              SettingsTile(
                key: const ValueKey('clear_cache'),
                title: t.settings.clear_cache,
                icon: Icons.cleaning_services_outlined,
                value: isClearingCache ? '...' : cacheSize,
                onTap: () => _handleClearCache(context, ref),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsGroup(
            children: [
              SettingsTile(
                key: const ValueKey('about'),
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

  String _getLanguageName(Translations t, AppLocale locale) => switch (locale) {
    AppLocale.zh => t.settings.chinese,
    AppLocale.zhHant => t.settings.traditional_chinese,
    AppLocale.en => t.settings.english,
  };

  String _getThemeName(Translations t, ThemeMode mode) => switch (mode) {
    ThemeMode.system => t.settings.theme_mode.system,
    ThemeMode.light => t.settings.theme_mode.light,
    ThemeMode.dark => t.settings.theme_mode.dark,
  };

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
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      useRootNavigator: true,
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
      context.showAppFeedback(t.common.refresh_completed);
    }
  }
}
