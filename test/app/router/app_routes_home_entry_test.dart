import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('app_routes.dart uses the home route entry instead of concrete home pages', () async {
    final appRoutesFile = File('lib/app/router/app_routes.dart');

    expect(appRoutesFile.existsSync(), isTrue, reason: 'app_routes.dart must exist');

    final content = await appRoutesFile.readAsString();

    expect(
      content,
      contains("import 'package:culcul/features/home/route_entry.dart';"),
    );
    expect(
      content,
      isNot(contains("import 'package:culcul/features/home/presentation/pages/home_page.dart';")),
    );
    expect(
      content,
      isNot(
        contains("import 'package:culcul/features/home/presentation/pages/weekly_screen.dart';"),
      ),
    );
  });

  test('home route entry re-exports the concrete home pages for router parts', () async {
    final routeEntryFile = File('lib/features/home/route_entry.dart');

    expect(routeEntryFile.existsSync(), isTrue, reason: 'home route entry must exist');

    final content = await routeEntryFile.readAsString();

    expect(
      content,
      contains("export 'presentation/pages/home_page.dart';"),
    );
    expect(
      content,
      contains("export 'presentation/pages/weekly_screen.dart';"),
    );
  });
}
