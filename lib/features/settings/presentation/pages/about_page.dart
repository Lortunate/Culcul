import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'about_page.sections.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(
          t.settings.sections.about,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surfaceContainerLowest,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: CustomScrollView(
        // Use BouncingScrollPhysics without AlwaysScrollableScrollPhysics.
        // This prevents the page from being draggable when the content fits on one screen,
        // solving the "strange scrolling behavior" and avoiding the Android 12 stretch effect.
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: _AboutHeader()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList.list(
              children: [
                _ActionTile(
                  icon: Icons.code_rounded,
                  title: 'GitHub Repository',
                  subtitle: 'Star us on GitHub',
                  onTap: () => launchUrlString(
                    'https://github.com/Houvven/Culcul',
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                const SizedBox(height: 12),
                _ActionTile(
                  icon: Icons.description_outlined,
                  title: 'Open Source Licenses',
                  subtitle: 'Libraries we use',
                  onTap: () => showLicensePage(
                    context: context,
                    applicationName: 'Culcul',
                    applicationVersion: 'v1.0.0',
                    useRootNavigator: true,
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 48, bottom: 24),
                  child: Text(
                    '© ${DateTime.now().year} Houvven. All rights reserved.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.outline,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
