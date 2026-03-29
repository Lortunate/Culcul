import 'package:culcul/app/app.dart';
import 'package:culcul/app/bootstrap/app_bootstrap.dart';
import 'package:culcul/core/providers/cache_store_provider.dart';
import 'package:culcul/core/providers/cookie_jar_provider.dart';
import 'package:culcul/core/providers/storage_provider.dart';
import 'package:culcul/core/services/audio_handler.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  final dependencies = await AppBootstrap.initialize();

  runApp(
    TranslationProvider(
      child: ProviderScope(
        overrides: [
          cookieJarProvider.overrideWithValue(dependencies.cookieJar),
          cacheStoreProvider.overrideWithValue(dependencies.cacheStore),
          storageBoxProvider.overrideWithValue(dependencies.storageBox),
          audioHandlerProvider.overrideWithValue(dependencies.audioHandler),
        ],
        child: const CulculApp(),
      ),
    ),
  );
}
