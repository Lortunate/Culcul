import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/ui/widgets/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  return TranslationProvider(
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  testWidgets('invokes callback without provider scope', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      _wrap(
        FollowButton(
          isFollowed: false,
          onTap: () {
            tapped = true;
          },
        ),
      ),
    );

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });

  testWidgets('renders default labels from follow state', (tester) async {
    await tester.pumpWidget(
      _wrap(
        Column(
          children: const [
            FollowButton(isFollowed: false, onTap: _noop),
            FollowButton(isFollowed: true, onTap: _noop),
          ],
        ),
      ),
    );

    final context = tester.element(find.byType(FollowButton).first);
    final t = Translations.of(context);

    expect(find.text('+ ${t.actions.follow}'), findsOneWidget);
    expect(find.text(t.actions.followed), findsOneWidget);
  });

  testWidgets('renders custom text override', (tester) async {
    const customText = 'Mutual';

    await tester.pumpWidget(
      _wrap(const FollowButton(isFollowed: true, text: customText, onTap: _noop)),
    );

    expect(find.text(customText), findsOneWidget);
  });
}

void _noop() {}
