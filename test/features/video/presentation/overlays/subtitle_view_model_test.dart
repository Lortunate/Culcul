import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/models/subtitle.dart';
import 'package:culcul/features/video/application/subtitle_application_providers.dart';
import 'package:culcul/features/video/application/subtitle_port.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_state.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/overlays/subtitle_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('subtitle content reads through the video subtitle application port', () async {
    const bvid = 'BV1xx411c7mD';
    const subtitleInfo = SubtitleInfo(
      id: 1,
      lan: 'en',
      lanDoc: 'English',
      subtitleUrl: 'https://example.test/subtitle.json',
    );
    const item = SubtitleItem(from: 0, to: 1.5, location: 2, content: 'hello');
    final port = _FakeSubtitlePort(const SubtitleContent(body: [item]));
    final container = ProviderContainer(
      overrides: [
        videoDetailControllerProvider(bvid).overrideWithValue(
          _videoDetailState(bvid, const VideoSubtitles(list: [subtitleInfo])),
        ),
        subtitlePortProvider.overrideWithValue(port),
        videoRepositoryProvider.overrideWith(
          (ref) =>
              throw StateError('videoRepositoryProvider should not be read by UI state'),
        ),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(subtitleControllerProvider(bvid).notifier);

    await notifier.selectSubtitle(subtitleInfo);

    final state = container.read(subtitleControllerProvider(bvid));
    expect(state.selectedSubtitle, subtitleInfo);
    expect(state.content, const [item]);
    expect(state.isLoading, false);
    expect(port.requests, const ['https://example.test/subtitle.json']);
  });

  test(
    'toggleSubtitle selects the first subtitle through the application port',
    () async {
      const bvid = 'BV1xx411c7mD';
      const subtitleInfo = SubtitleInfo(
        id: 2,
        lan: 'zh-CN',
        lanDoc: 'Chinese',
        subtitleUrl: 'https://example.test/zh.json',
      );
      const item = SubtitleItem(from: 2, to: 3, location: 2, content: 'hello zh');
      final port = _FakeSubtitlePort(const SubtitleContent(body: [item]));
      final container = ProviderContainer(
        overrides: [
          videoDetailControllerProvider(bvid).overrideWithValue(
            _videoDetailState(bvid, const VideoSubtitles(list: [subtitleInfo])),
          ),
          subtitlePortProvider.overrideWithValue(port),
          videoRepositoryProvider.overrideWith(
            (ref) => throw StateError(
              'videoRepositoryProvider should not be read by UI state',
            ),
          ),
        ],
      );
      addTearDown(container.dispose);

      final notifier = container.read(subtitleControllerProvider(bvid).notifier);

      await notifier.toggleSubtitle();

      final state = container.read(subtitleControllerProvider(bvid));
      expect(state.isEnabled, true);
      expect(state.selectedSubtitle, subtitleInfo);
      expect(state.content, const [item]);
      expect(port.requests, const ['https://example.test/zh.json']);
    },
  );
}

final class _FakeSubtitlePort implements SubtitlePort {
  _FakeSubtitlePort(this.content);

  final SubtitleContent content;
  final requests = <String>[];

  @override
  Future<Result<SubtitleContent, AppError>> fetchSubtitleContent(String url) async {
    requests.add(url);
    return Success(content);
  }
}

VideoDetailState _videoDetailState(String bvid, VideoSubtitles subtitles) {
  return VideoDetailState(
    isLoading: false,
    videoDetail: VideoDetailViewData(
      bvid: bvid,
      aid: 1,
      title: 'Video',
      pic: '',
      pubDate: 0,
      desc: '',
      owner: const VideoOwner(mid: 1, name: 'Uploader'),
      stat: const VideoStat(),
      subtitle: subtitles,
    ),
  );
}
