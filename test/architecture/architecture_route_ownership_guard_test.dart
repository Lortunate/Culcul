import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dynamic detail and publish routes live in the dynamic route part', () {
    final dynamicRoutes = File('lib/app/router/routes/app_dynamic_routes.dart');
    final notificationRoutes = File('lib/app/router/routes/app_notification_routes.dart');

    expect(dynamicRoutes.existsSync(), isTrue);

    final dynamicRouteSource = dynamicRoutes.readAsStringSync();
    expect(dynamicRouteSource, contains('class DynamicDetailRoute'));
    expect(dynamicRouteSource, contains('class PublishDynamicRoute'));

    final notificationRouteSource = notificationRoutes.readAsStringSync();
    expect(notificationRouteSource, isNot(contains('class DynamicDetailRoute')));
    expect(notificationRouteSource, isNot(contains('class PublishDynamicRoute')));
  });
}
