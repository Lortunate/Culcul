import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _allowedBootstrapImports = {
  'lib/app/runtime/root_overrides.dart',
  'lib/core/data/network/dio_client.dart',
  'lib/core/data/network/interceptors/csrf_interceptor.dart',
  'lib/features/auth/data/auth_repository_impl.dart',
  'lib/features/dynamic/data/dynamic_repository_impl.dart',
  'lib/features/dynamic/presentation/view_models/user_dynamic_view_model.dart',
  'lib/features/home/presentation/view_models/home_feed_paging_mixin.dart',
  'lib/features/profile/data/user_info_cache_repository.dart',
  'lib/features/profile/presentation/view_models/user_space_videos_view_model.dart',
  'lib/features/search/presentation/view_models/search_history_view_model.dart',
  'lib/features/search/presentation/view_models/search_view_model.dart',
  'lib/features/settings/data/settings_repository_impl.dart',
};

void main() {
  test('production bootstrap-provider imports stay behind runtime/core seams', () async {
    final violations = <String>[];
    final libDir = Directory('lib');

    if (!libDir.existsSync()) {
      fail('lib/ directory must exist');
    }

    await for (final entity in libDir.list(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }

      final normalizedPath = entity.path.replaceAll('\\', '/');
      if (normalizedPath.endsWith('.g.dart') ||
          normalizedPath.endsWith('.freezed.dart')) {
        continue;
      }
      if (_isAllowed(normalizedPath)) {
        continue;
      }

      final content = await entity.readAsString();
      final directives = _extractForbiddenDirectives(content);
      for (final directive in directives) {
        violations.add('$normalizedPath -> $directive');
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Feature code must not import bootstrap-owned providers directly.\n'
          'Found violations:\n${violations.join('\n')}',
    );
  });
}

bool _isAllowed(String normalizedPath) {
  return _allowedBootstrapImports.contains(normalizedPath) ||
      normalizedPath.startsWith('lib/core/bootstrap/providers/');
}

List<String> _extractForbiddenDirectives(String content) {
  final matches = <String>[];
  final pattern = RegExp(
    r'''^\s*(?:import|export)\s+['"]((?:package:culcul/core/bootstrap/providers|package:culcul/shared/providers)/[^'"]+)['"][^;]*;''',
    multiLine: true,
  );
  for (final match in pattern.allMatches(content)) {
    matches.add(match.group(1)!);
  }
  return matches;
}
