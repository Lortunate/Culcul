import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/network/bilibili_acceleration.dart';
import 'package:culcul/features/settings/presentation/view_models/settings_view_model.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_selection_item.dart';
import 'package:culcul/features/settings/presentation/widgets/settings_selection_sheet.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/app_clickable.dart';
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
    final accelerationState = ref.watch(bilibiliAccelerationControllerProvider);
    final activePreset = biliPresetById(accelerationState.activePresetId);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: _SettingsAppBar(title: t.settings.title),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: <Widget>[
          _SettingsSectionLabel(title: t.settings.sections.general),
          _SettingsListRow(
            key: const ValueKey<String>('settings_row_language'),
            title: t.settings.language,
            value: _getLanguageName(t, LocaleSettings.currentLocale),
            onTap: () => _showLanguageSelector(context),
          ),
          const SizedBox(height: 16),
          _SettingsSectionLabel(title: t.settings.sections.appearance),
          _SettingsListRow(
            key: const ValueKey<String>('settings_row_appearance'),
            title: t.settings.appearance,
            value: _getThemeName(t, themeMode),
            onTap: () => _showThemeSelector(context, ref, themeMode),
          ),
          const SizedBox(height: 16),
          _SettingsSectionLabel(title: t.settings.sections.network),
          _SettingsListRow(
            key: const ValueKey<String>('settings_row_network'),
            title: t.settings.network.page_title,
            value: _getPresetName(t, activePreset.id),
            onTap: () => const NetworkSettingsRoute().push(context),
          ),
          const SizedBox(height: 16),
          _SettingsSectionLabel(title: t.settings.sections.storage),
          _SettingsListRow(
            key: const ValueKey<String>('settings_row_cache'),
            title: t.settings.clear_cache,
            value: isClearingCache ? '...' : cacheSize,
            onTap: () => _handleClearCache(context, ref),
          ),
          const SizedBox(height: 16),
          _SettingsSectionLabel(title: t.settings.sections.about),
          _SettingsListRow(
            key: const ValueKey<String>('settings_row_version'),
            title: t.settings.version,
            value: 'v1.0.0',
            showArrow: false,
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

  String _getPresetName(Translations t, String presetId) {
    return switch (presetId) {
      'official_direct' => t.settings.network.presets.official_direct,
      'dns_backup' => t.settings.network.presets.dns_backup,
      'cdn_cos' => t.settings.network.presets.cdn_cos,
      'cdn_ks3' => t.settings.network.presets.cdn_ks3,
      'cdn_ali' => t.settings.network.presets.cdn_ali,
      _ => presetId,
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
      backgroundColor: colorScheme.surface,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        onPressed: () => context.pop(),
      ),
    );
  }
}

class _SettingsSectionLabel extends StatelessWidget {
  const _SettingsSectionLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SettingsListRow extends StatelessWidget {
  const _SettingsListRow({
    super.key,
    required this.title,
    this.value,
    this.onTap,
    this.showArrow = true,
  });

  final String title;
  final String? value;
  final VoidCallback? onTap;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppClickable(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 58),
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (value != null)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  value!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            if (showArrow) ...[
              const SizedBox(width: 6),
              Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
