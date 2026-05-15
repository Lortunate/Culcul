import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/core/feedback/app_feedback.dart';
import 'package:culcul/features/settings/application/settings_controller.dart';
import 'package:culcul/ui/ui.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CulculApp extends ConsumerWidget {
  const CulculApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      title: 'Culcul',
      scaffoldMessengerKey: globalScaffoldMessengerKey,
      theme: CulculTheme.light,
      darkTheme: CulculTheme.dark,
      themeMode: themeMode,
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
