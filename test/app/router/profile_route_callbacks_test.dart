import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('profile route callbacks are constructed through one router helper', () {
    final shellSource = File(
      'lib/app/router/routes/app_shell_routes.dart',
    ).readAsStringSync();
    final socialSource = File(
      'lib/app/router/routes/app_social_routes.dart',
    ).readAsStringSync();
    final combinedSource = '$shellSource\n$socialSource';

    expect(
      combinedSource,
      contains('ProfileRouteNavigation _profileRouteNavigation(BuildContext context)'),
    );

    for (final className in <String>[
      'ProfileRoute',
      'FollowingsRoute',
      'FollowersRoute',
      'UserProfileRoute',
    ]) {
      final routeSource = _classSource(combinedSource, className);

      expect(routeSource, contains('navigation: _profileRouteNavigation(context)'));
      expect(routeSource, isNot(contains('onOpenSettings:')));
      expect(routeSource, isNot(contains('onOpenFollowings:')));
      expect(routeSource, isNot(contains('onOpenChat:')));
    }
  });
}

String _classSource(String source, String className) {
  final start = source.indexOf('class $className ');
  expect(start, isNonNegative, reason: '$className is missing');

  final bodyStart = source.indexOf('{', start);
  expect(bodyStart, isNonNegative, reason: '$className body is missing');

  var depth = 0;
  for (var index = bodyStart; index < source.length; index++) {
    final char = source.codeUnitAt(index);
    if (char == 123) {
      depth++;
    } else if (char == 125) {
      depth--;
      if (depth == 0) {
        return source.substring(start, index + 1);
      }
    }
  }

  fail('$className body is not closed');
}
