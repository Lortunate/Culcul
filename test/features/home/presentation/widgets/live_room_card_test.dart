import 'package:culcul/core/contracts/live_room_summary_contract.dart';
import 'package:culcul/features/home/presentation/widgets/home_layout_spec.dart';
import 'package:culcul/features/home/presentation/widgets/live_room_card.dart';
import 'package:culcul/ui/widgets/users/app_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('live grid gives cards enough room for readable metadata', (tester) async {
    final mobileDelegate = await _liveGridDelegate(tester, const Size(390, 844));
    expect(mobileDelegate.crossAxisCount, 2);
    expect(mobileDelegate.childAspectRatio, 0.98);

    final desktopDelegate = await _liveGridDelegate(tester, const Size(1440, 900));
    expect(desktopDelegate.crossAxisCount, 5);
    expect(desktopDelegate.childAspectRatio, 1.02);
  });

  testWidgets('fits the live grid cell without vertical overflow', (tester) async {
    await tester.pumpWidget(
      const _TestApp(
        child: SizedBox(
          width: 161.6,
          height: 161.6 / 0.98,
          child: LiveRoomCard(room: _room),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(tester.getSize(find.byType(AppAvatar)), const Size.square(16));

    final title = tester.widget<Text>(find.text(_room.title));
    expect(title.style?.fontSize, 12.5);

    final uname = tester.widget<Text>(find.text(_room.uname));
    expect(uname.style?.fontSize, 10.5);
  });
}

Future<SliverGridDelegateWithFixedCrossAxisCount> _liveGridDelegate(
  WidgetTester tester,
  Size screenSize,
) async {
  late SliverGridDelegateWithFixedCrossAxisCount delegate;
  await tester.pumpWidget(
    MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: screenSize),
        child: Builder(
          builder: (context) {
            delegate = HomeGridLayoutSpec.live(context).gridDelegate;
            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );
  return delegate;
}

const _room = LiveRoomSummary(
  roomId: 1,
  uid: 2,
  title: 'A long live room title that should wrap across two lines',
  uname: 'Live user name',
  cover: '',
  face: '',
  online: 123456,
  areaName: 'Games',
  parentAreaName: 'Live',
  link: '',
);

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }
}
