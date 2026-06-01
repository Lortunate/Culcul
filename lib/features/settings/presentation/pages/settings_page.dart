import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:culcul/features/settings/data/settings_repository_impl.dart';
import 'package:culcul/features/settings/settings.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/buttons/app_clickable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _cacheSizeProvider = FutureProvider.autoDispose<String>((ref) async {
  final totalSize = await ref.read(settingsRepositoryProvider).getCacheSizeInBytes();
  return totalSize.formatFileSize;
});

class SettingsPage extends ConsumerStatefulWidget {
  final VoidCallback onOpenAbout;

  const SettingsPage({required this.onOpenAbout, super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _isClearingCache = false;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final themeMode = ref.watch(appThemeModeProvider);
    final cacheState = ref.watch(_cacheSizeProvider);
    final cacheSize = cacheState.when(
      data: (value) => value,
      loading: () => '...',
      error: (error, stackTrace) => '0 B',
    );

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
          _SettingsGroup(
            children: [
              _SettingsTile(
                key: const ValueKey('appearance'),
                title: t.settings.appearance,
                icon: Icons.palette_outlined,
                value: _getThemeName(t, themeMode),
                onTap: () {
                  _showSelectionSheet(
                    context,
                    title: t.settings.sections.appearance,
                    children: ThemeMode.values.map((mode) {
                      return _SettingsSelectionItem(
                        title: _getThemeName(t, mode),
                        isSelected: themeMode == mode,
                        onTap: () {
                          ref.read(appThemeModeProvider.notifier).setTheme(mode);
                          context.pop();
                        },
                      );
                    }).toList(),
                  );
                },
              ),
              _SettingsTile(
                key: const ValueKey('language'),
                title: t.settings.language,
                icon: Icons.language_outlined,
                value: _getLanguageName(t, LocaleSettings.currentLocale),
                onTap: () {
                  _showSelectionSheet(
                    context,
                    title: t.settings.language,
                    children: AppLocale.values.map((locale) {
                      return _SettingsSelectionItem(
                        title: _getLanguageName(t, locale),
                        isSelected: LocaleSettings.currentLocale == locale,
                        onTap: () {
                          LocaleSettings.setLocale(locale);
                          context.pop();
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingsGroup(
            children: [
              _SettingsTile(
                key: const ValueKey('clear_cache'),
                title: t.settings.clear_cache,
                icon: Icons.cleaning_services_outlined,
                value: _isClearingCache ? '...' : cacheSize,
                onTap: () async {
                  if (_isClearingCache) return;
                  setState(() => _isClearingCache = true);
                  try {
                    await ref.read(settingsRepositoryProvider).clearCache();
                    ref.invalidate(_cacheSizeProvider);
                  } catch (_) {
                    // Keep prior behavior: clear errors are intentionally not surfaced.
                  } finally {
                    if (mounted) {
                      setState(() => _isClearingCache = false);
                    }
                  }
                  if (context.mounted) {
                    context.showAppFeedback(t.common.refresh_completed);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingsGroup(
            children: [
              _SettingsTile(
                key: const ValueKey('about'),
                title: t.settings.sections.about,
                icon: Icons.info_outline_rounded,
                onTap: widget.onOpenAbout,
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
      builder: (context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

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
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;

  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children.asMap().entries.map((entry) {
          final isLast = entry.key == children.length - 1;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              entry.value,
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final String? value;
  final IconData? icon;
  final VoidCallback? onTap;

  const _SettingsTile({
    super.key,
    required this.title,
    this.value,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final child = Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 24, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16)),
              ],
            ),
          ),
          if (value != null)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                value!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          if (onTap != null) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ],
        ],
      ),
    );

    if (onTap == null) {
      return child;
    }

    return AppClickable(onTap: onTap, child: child);
  }
}

class _SettingsSelectionItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SettingsSelectionItem({
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
