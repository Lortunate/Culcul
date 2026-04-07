import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/presentation/view_models/video_comments_view_model.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_state.dart';
import 'package:culcul/features/video/presentation/view_models/video_detail_view_model.dart';
import 'package:culcul/features/video/video.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('ensureLoaded lazily triggers first comments request once', () async {
    final repository = _FakeVideoRepository();
    final container = ProviderContainer(
      overrides: [
        videoRepositoryProvider.overrideWithValue(repository),
        videoDetailControllerProvider('BV1').overrideWithValue(
          VideoDetailState(
            isLoading: false,
            videoDetail: _buildVideoDetail(),
            currentCid: 1001,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    container.read(videoCommentsControllerProvider('BV1'));
    expect(repository.fetchCommentsCount, 0);

    await container.read(videoCommentsControllerProvider('BV1').notifier).ensureLoaded();
    expect(repository.fetchCommentsCount, 1);

    await container.read(videoCommentsControllerProvider('BV1').notifier).ensureLoaded();
    expect(repository.fetchCommentsCount, 1);
  });
}

class _FakeVideoRepository extends Fake implements VideoRepository {
  int fetchCommentsCount = 0;

  @override
  Future<Result<CommentResponse, AppError>> fetchComments({
    required int oid,
    CommentSort sort = CommentSort.hot,
    int page = 1,
  }) async {
    fetchCommentsCount++;
    return Success(CommentResponse(replies: <CommentItem>[_buildCommentItem()]));
  }
}

VideoDetail _buildVideoDetail() {
  return VideoDetail(
    bvid: 'BV1',
    aid: 100,
    videos: 1,
    tid: 1,
    tname: 'test',
    copyright: 1,
    pic: 'https://example.com/pic.jpg',
    title: 'title',
    pubDate: 0,
    ctime: 0,
    desc: 'desc',
    owner: const Owner(mid: 1, name: 'owner'),
    stat: const Stat(),
    pages: const <VideoPage>[VideoPage(cid: 1001)],
  );
}

CommentItem _buildCommentItem() {
  return CommentItem(
    rpid: 1,
    oid: 100,
    type: 1,
    mid: 1,
    root: 0,
    parent: 0,
    ctime: 0,
    member: const CommentMember(
      mid: '1',
      uname: 'user',
      sex: '',
      sign: '',
      avatar: '',
      rank: '0',
      levelInfo: CommentLevelInfo(
        currentLevel: 0,
        currentMin: 0,
        currentExp: 0,
        nextExp: 0,
      ),
      pendant: CommentPendant(pid: 0, name: '', image: '', expire: 0),
      nameplate: CommentNameplate(
        nid: 0,
        name: '',
        image: '',
        imageSmall: '',
        level: '',
        condition: '',
      ),
      officialVerify: CommentOfficialVerify(),
      vip: CommentVip(),
    ),
    content: const CommentContent(message: 'hello'),
  );
}
