import 'package:culcul/features/dynamic/domain/entities/article_detail_data.dart';
import 'package:culcul/features/dynamic/presentation/pages/article_detail_page.dart';
import 'package:culcul/features/dynamic/presentation/widgets/dynamic_navigation_scope.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('paragraph link recognizer survives unchanged rebuild', (tester) async {
    final events = _GestureRecognizerEvents();
    final openedArticles = <String>[];
    events.start();
    addTearDown(events.stop);

    await tester.pumpWidget(
      _ArticleBlocksTestApp(
        blocks: [_paragraphLink('/read/cv12345')],
        onOpenArticle: (url, _) => openedArticles.add(url),
      ),
    );

    expect(events.createdCount, 1);
    expect(events.disposedCount, 0);

    await tester.pumpWidget(
      _ArticleBlocksTestApp(
        blocks: [_paragraphLink('/read/cv12345')],
        onOpenArticle: (url, _) => openedArticles.add(url),
      ),
    );

    expect(events.createdCount, 1);
    expect(events.disposedCount, 0);

    await tester.tap(find.text('Read more'));
    await tester.pump();

    expect(openedArticles, ['https://www.bilibili.com/read/cv12345']);
  });

  testWidgets('paragraph link tap target updates without recreating recognizer', (
    tester,
  ) async {
    final events = _GestureRecognizerEvents();
    final openedArticles = <String>[];
    events.start();
    addTearDown(events.stop);

    await tester.pumpWidget(
      _ArticleBlocksTestApp(
        blocks: [_paragraphLink('/read/cv12345')],
        onOpenArticle: (url, _) => openedArticles.add(url),
      ),
    );
    await tester.pumpWidget(
      _ArticleBlocksTestApp(
        blocks: [_paragraphLink('/read/cv67890')],
        onOpenArticle: (url, _) => openedArticles.add(url),
      ),
    );

    expect(events.createdCount, 1);
    expect(events.disposedCount, 0);

    await tester.tap(find.text('Read more'));
    await tester.pump();

    expect(openedArticles, ['https://www.bilibili.com/read/cv67890']);
  });

  testWidgets('paragraph link recognizer disposes after link update and removal', (
    tester,
  ) async {
    final updateEvents = _GestureRecognizerEvents();
    updateEvents.start();
    addTearDown(updateEvents.stop);

    await tester.pumpWidget(
      _ArticleBlocksTestApp(blocks: [_paragraphLink('/read/cv12345')]),
    );
    await tester.pumpWidget(_ArticleBlocksTestApp(blocks: [_plainParagraph()]));

    expect(updateEvents.createdCount, 1);
    expect(updateEvents.disposedCount, 1);

    final removalEvents = _GestureRecognizerEvents();
    updateEvents.stop();
    removalEvents.start();
    addTearDown(removalEvents.stop);

    await tester.pumpWidget(
      _ArticleBlocksTestApp(blocks: [_paragraphLink('/read/cv12345')]),
    );
    await tester.pumpWidget(const SizedBox());

    expect(removalEvents.createdCount, 1);
    expect(removalEvents.disposedCount, 1);
  });
}

class _ArticleBlocksTestApp extends StatelessWidget {
  const _ArticleBlocksTestApp({required this.blocks, this.onOpenArticle});

  final List<ArticleBlock> blocks;
  final void Function(String url, String? title)? onOpenArticle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DynamicNavigationScope(
        onOpenUser: (_) {},
        onOpenVideo: (_) {},
        onOpenLiveRoom: (_) {},
        onOpenDynamicDetail: (_) {},
        onOpenArticle: onOpenArticle ?? (_, _) {},
        onOpenTopic: (_, _) {},
        child: Scaffold(
          body: Builder(
            builder: (context) {
              return Column(children: buildArticleBlocks(context, blocks));
            },
          ),
        ),
      ),
    );
  }
}

class _GestureRecognizerEvents {
  final List<ObjectEvent> _events = <ObjectEvent>[];
  late final ObjectEventListener _listener = _events.add;
  bool _isListening = false;

  int get createdCount => _events.where(_isGestureRecognizerCreated).length;
  int get disposedCount => _events.where(_isGestureRecognizerDisposed).length;

  void start() {
    if (_isListening) return;
    FlutterMemoryAllocations.instance.addListener(_listener);
    _isListening = true;
  }

  void stop() {
    if (!_isListening) return;
    FlutterMemoryAllocations.instance.removeListener(_listener);
    _isListening = false;
  }

  bool _isGestureRecognizerCreated(ObjectEvent event) {
    return event is ObjectCreated &&
        event.library == 'package:flutter/gestures.dart' &&
        event.className == 'GestureRecognizer' &&
        _isParagraphRecognizer(event.object);
  }

  bool _isGestureRecognizerDisposed(ObjectEvent event) {
    return event is ObjectDisposed && _isParagraphRecognizer(event.object);
  }

  bool _isParagraphRecognizer(Object object) {
    return object is GestureRecognizer &&
        object.debugOwner.runtimeType.toString() == '_ParagraphBlockViewState';
  }
}

ArticleBlock _plainParagraph() {
  return const ArticleBlock.paragraph(nodes: [ArticleInlineNode(text: 'Plain text')]);
}

ArticleBlock _paragraphLink(String linkUrl) {
  return ArticleBlock.paragraph(
    nodes: [ArticleInlineNode(text: 'Read more', linkUrl: linkUrl)],
  );
}
