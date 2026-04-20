import 'package:culcul/i18n/strings.g.dart';
import 'package:culcul/shared/widgets/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestSubject({
    required bool isFollowed,
    required VoidCallback onTap,
    String? text,
  }) {
    return TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: FollowButton(
            isFollowed: isFollowed,
            onTap: onTap,
            text: text,
          ),
        ),
      ),
    );
  }

  testWidgets('invokes onTap when pressed', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      buildTestSubject(
        isFollowed: false,
        onTap: () => tapped = true,
      ),
    );

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });

  testWidgets('renders provided custom text', (tester) async {
    await tester.pumpWidget(
      buildTestSubject(
        isFollowed: true,
        onTap: () {},
        text: 'Custom label',
      ),
    );

    expect(find.text('Custom label'), findsOneWidget);
  });
}
