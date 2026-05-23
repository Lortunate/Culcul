import 'package:culcul/features/auth/application/auth_session_providers.dart';
import 'package:culcul/features/favorites/route_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('showVideoFavoritePicker redirects to login when logged out', (
    tester,
  ) async {
    var loginCalls = 0;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [currentUserProvider.overrideWith((ref) => null)],
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () async {
                  final result = await showVideoFavoritePicker(
                    context: context,
                    aid: 100,
                    onLogin: () {
                      loginCalls++;
                    },
                  );

                  expect(result, isNull);
                },
                child: const Text('open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(loginCalls, 1);
    expect(find.byType(BottomSheet), findsNothing);
  });
}
