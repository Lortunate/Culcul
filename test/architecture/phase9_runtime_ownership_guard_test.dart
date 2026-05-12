import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('main.dart uses runtime bootstrap and root override entrypoints', () async {
    final content = await File('lib/main.dart').readAsString();

    expect(content, contains("package:culcul/app/runtime/bootstrap_coordinator.dart"));
    expect(content, contains("package:culcul/app/runtime/root_overrides.dart"));
    expect(
      content,
      isNot(contains("package:culcul/app/bootstrap/provider_overrides.dart")),
    );
    expect(
      content,
      isNot(
        contains(
          "package:culcul/features/auth/application/auth_session_cookie_refresher.dart",
        ),
      ),
    );
  });

  test('app runtime bootstrap stays typed and box-free', () async {
    final runtimeContent = await File('lib/app/runtime/app_runtime.dart').readAsString();
    final bootstrapContent = await File(
      'lib/app/bootstrap/app_bootstrap.dart',
    ).readAsString();

    expect(runtimeContent, isNot(contains('Box<dynamic>')));
    expect(runtimeContent, contains('class AppRuntime'));
    expect(runtimeContent, contains('PersistCookieJar'));
    expect(runtimeContent, contains('FileCacheStore'));
    expect(runtimeContent, contains('SharedPreferences'));
    expect(bootstrapContent, contains('Future<AppRuntime> initialize()'));
    expect(bootstrapContent, contains('return AppRuntime('));
  });

  test('root overrides own runtime boot wiring and verification', () async {
    final file = File('lib/app/runtime/root_overrides.dart');

    expect(file.existsSync(), isTrue, reason: 'root_overrides.dart must exist');

    final content = await file.readAsString();
    expect(content, contains('sessionCookieRefresherProvider'));
    expect(content, contains('verifyRootOverrides'));
    expect(content, contains('watchLaterPortProvider'));
    expect(content, contains('currentUserProvider'));
    expect(content, contains('userCardProvider'));
    expect(content, contains('userProfileLookupProvider'));
    expect(content, contains('modifyRelationProvider'));
    expect(content, contains('relationPortProvider'));
    expect(content, contains('searchPortProvider'));
  });

  test('core session lifecycle providers stay free of login dialog wiring', () async {
    final content = await File(
      'lib/core/session/session_lifecycle_providers.dart',
    ).readAsString();

    expect(content, isNot(contains('ShowLoginDialog')));
    expect(content, isNot(contains('showLoginDialogProvider')));
  });

  test('watch later runtime seam uses a neutral port contract', () async {
    final portFile = File('lib/core/contracts/watch_later_port.dart');
    final providerFile = File('lib/core/session/feature_action_providers.dart');

    expect(portFile.existsSync(), isTrue, reason: 'watch_later_port.dart must exist');

    final portContent = await portFile.readAsString();
    final providerContent = await providerFile.readAsString();

    expect(portContent, contains('abstract interface class WatchLaterPort'));
    expect(providerContent, contains('watchLaterPortProvider'));
    expect(providerContent, isNot(contains('watchLaterActionsProvider')));
  });
}
