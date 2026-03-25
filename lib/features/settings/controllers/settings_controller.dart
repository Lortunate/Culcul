import 'dart:io';

import 'package:culcul/core/providers/storage_provider.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _themeKey = 'theme_mode';

  @override
  ThemeMode build() {
    final box = ref.read(storageBoxProvider);
    return switch (box.get(_themeKey) as String?) {
      final themeString? => ThemeMode.values.firstWhere(
        (e) => e.toString() == themeString,
        orElse: () => ThemeMode.system,
      ),
      null => ThemeMode.system,
    };
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final box = ref.read(storageBoxProvider);
    await box.put(_themeKey, mode.toString());
  }
}

final cacheSizeProvider = FutureProvider.autoDispose<String>((ref) async {
  try {
    final tempDir = await getTemporaryDirectory();
    if (!tempDir.existsSync()) return '0 B';

    final totalSize = await _calculateSize(tempDir);
    return totalSize.formatFileSize;
  } catch (_) {
    return '0 B';
  }
});

Future<int> _calculateSize(FileSystemEntity file) async {
  if (file is File) {
    try {
      return await file.length();
    } catch (_) {
      return 0;
    }
  }
  if (file is Directory) {
    var sum = 0;
    try {
      await for (final child in file.list(recursive: false, followLinks: false)) {
        sum += await _calculateSize(child);
      }
    } catch (_) {}
    return sum;
  }
  return 0;
}

final clearCacheProvider = Provider.autoDispose((ref) {
  return () async {
    try {
      final tempDir = await getTemporaryDirectory();
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
      ref.invalidate(cacheSizeProvider);
    } catch (e) {
      debugPrint('Failed to clear cache: $e');
    }
  };
});

