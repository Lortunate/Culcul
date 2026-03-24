import 'package:culcul/app/router/app_routes.dart';
import 'package:culcul/app/theme/culcul_theme.dart';
import 'package:culcul/core/utils/toast_utils.dart';
import 'package:culcul/features/settings/logic/settings_controller.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CulculApp extends ConsumerWidget {
  const CulculApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Culcul',
      scaffoldMessengerKey: globalScaffoldMessengerKey,
      theme: CulculTheme.light,
      darkTheme: CulculTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
