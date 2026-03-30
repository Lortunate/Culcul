import 'dart:io';

import 'package:culcul/core/providers/storage_provider.dart';
import 'package:culcul/core/utils/format_extensions.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_view_model.g.dart';

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() {
    final box = ref.watch(settingsStorageBoxProvider);
    return switch (box.get(StorageKeys.themeMode) as String?) {
      final themeString? => ThemeMode.values.firstWhere(
        (e) => e.toString() == themeString,
        orElse: () => ThemeMode.system,
      ),
      null => ThemeMode.system,
    };
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final box = ref.read(settingsStorageBoxProvider);
    await box.put(StorageKeys.themeMode, mode.toString());
  }
}

@riverpod
Future<String> cacheSize(Ref ref) async {
  try {
    final tempDir = await getTemporaryDirectory();
    if (!tempDir.existsSync()) return '0 B';

    final totalSize = await _calculateSize(tempDir);
    return totalSize.formatFileSize;
  } catch (_) {
    return '0 B';
  }
}

@riverpod
class CacheMaintenance extends _$CacheMaintenance {
  @override
  FutureOr<void> build() {}

  Future<void> clear() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final tempDir = await getTemporaryDirectory();
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
      ref.invalidate(cacheSizeProvider);
    });
  }
}

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
