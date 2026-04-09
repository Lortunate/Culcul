import 'package:culcul/features/profile/presentation/widgets/profile_action_grid.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildProfileActionGrid(double width) {
  return TranslationProvider(
    child: MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: Size(width, 900)),
        child: const Scaffold(body: CustomScrollView(slivers: [ProfileActionGrid()])),
      ),
    ),
  );
}

void main() {
  testWidgets('desktop profile action grid shows extended actions', (tester) async {
    await tester.pumpWidget(_buildProfileActionGrid(1366));

    expect(find.byIcon(Icons.palette_outlined), findsOneWidget);
    expect(find.byIcon(Icons.support_agent_outlined), findsOneWidget);
  });

  testWidgets('mobile profile action grid keeps base actions', (tester) async {
    await tester.pumpWidget(_buildProfileActionGrid(390));

    expect(find.byIcon(Icons.palette_outlined), findsNothing);
    expect(find.byIcon(Icons.support_agent_outlined), findsNothing);
    expect(find.byIcon(Icons.history_rounded), findsOneWidget);
    expect(find.byIcon(Icons.star_outline_rounded), findsOneWidget);
  });
}
