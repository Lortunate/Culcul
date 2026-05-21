import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/features/video/presentation/detail/info/video_description.dart';
import 'package:culcul/features/video/presentation/detail/info/video_info_view.dart';
import 'package:culcul/features/video/presentation/detail/info/video_recommendation.dart';
import 'package:culcul/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('VideoCollectionSummary normalizes empty page count', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: VideoCollectionSummary(label: 'Parts', title: 'Demo video', pageCount: 0),
        ),
      ),
    );

    expect(find.text('Parts - Demo video'), findsOneWidget);
    expect(find.text('1/1'), findsOneWidget);
  });

  testWidgets('ExpandableDescriptionAndTags reveals tags after tapping', (tester) async {
    await tester.pumpWidget(
      const _TestApp(
        child: ExpandableDescriptionAndTags(
          description:
              'A long video description that should stay collapsed until the user asks for more.',
          tags: [
            VideoTagViewData(tagName: 'flutter'),
            VideoTagViewData(tagName: 'design'),
          ],
        ),
      ),
    );

    expect(find.text('flutter'), findsNothing);
    expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsOneWidget);

    await tester.tap(find.byType(ExpandableDescriptionAndTags));
    await tester.pumpAndSettle();

    expect(find.text('flutter'), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_up_rounded), findsOneWidget);
  });

  testWidgets('RecommendationItem keeps recommendation reason badge', (tester) async {
    await tester.pumpWidget(
      const _TestApp(
        child: RecommendationItem(
          video: VideoModel(
            bvid: 'BV1xx411c7mD',
            title: 'Recommended video',
            pic: '',
            owner: VideoOwner(mid: 1, name: 'Uploader'),
            stat: VideoStat(view: 1000, danmaku: 20),
            duration: 90,
            pubDate: 0,
            rcmdReason: 'Because you watched Flutter',
          ),
        ),
      ),
    );

    expect(find.text('Because you watched Flutter'), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: MaterialApp(
        home: Scaffold(body: child),
        locale: AppLocale.zh.flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
      ),
    );
  }
}
