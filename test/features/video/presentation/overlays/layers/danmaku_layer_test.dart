import 'package:culcul/core/contracts/video_model_contract.dart';
import 'package:culcul/core/errors/app_error.dart';
import 'package:culcul/core/result/result.dart';
import 'package:culcul/features/video/application/video_detail_models.dart';
import 'package:culcul/features/video/application/video_extra_workflows.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_state.dart';
import 'package:culcul/features/video/presentation/detail/video_detail_view_model.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku_mask_view_model.dart';
import 'package:culcul/features/video/presentation/overlays/danmaku_settings_view_model.dart';
import 'package:culcul/features/video/presentation/overlays/layers/danmaku_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('does not watch mask provider when danmaku is disabled', (tester) async {
    var maskLoads = 0;

    await tester.pumpWidget(
      _TestApp(
        settings: const DanmakuSettings(isEnabled: false),
        detailState: _videoDetailState(aid: 123, currentCid: 456),
        maskOid: 456,
        maskPid: 123,
        onMaskLoad: () => maskLoads++,
      ),
    );
    await tester.pump();

    expect(maskLoads, 0);
  });

  testWidgets('does not watch mask provider when aid is missing', (tester) async {
    var maskLoads = 0;

    await tester.pumpWidget(
      _TestApp(
        detailState: _videoDetailState(aid: null, currentCid: 456),
        maskOid: 456,
        maskPid: 0,
        onMaskLoad: () => maskLoads++,
      ),
    );
    await tester.pump();

    expect(maskLoads, 0);
  });

  testWidgets('does not watch mask provider when current cid is zero', (tester) async {
    var maskLoads = 0;

    await tester.pumpWidget(
      _TestApp(
        detailState: _videoDetailState(aid: 123, currentCid: 0),
        maskOid: 0,
        maskPid: 123,
        onMaskLoad: () => maskLoads++,
      ),
    );
    await tester.pump();

    expect(maskLoads, 0);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({
    required this.detailState,
    required this.maskOid,
    required this.maskPid,
    required this.onMaskLoad,
    this.settings = const DanmakuSettings(),
  });

  static const bvid = 'BV1xx411c7mD';

  final VideoDetailState detailState;
  final DanmakuSettings settings;
  final int maskOid;
  final int maskPid;
  final VoidCallback onMaskLoad;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        danmakuSettingsControllerProvider.overrideWithValue(settings),
        videoDetailControllerProvider(bvid).overrideWithValue(detailState),
        danmakuMaskProvider(oid: maskOid, pid: maskPid).overrideWith((ref) async {
          onMaskLoad();
          return const Success<DanmakuMasks?, AppError>(null);
        }),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: SizedBox(width: 320, height: 180, child: DanmakuLayer(bvid: bvid)),
        ),
      ),
    );
  }
}

VideoDetailState _videoDetailState({required int? aid, required int currentCid}) {
  return VideoDetailState(
    isLoading: false,
    currentCid: currentCid,
    videoDetail: aid == null ? null : _videoDetail(aid),
  );
}

VideoDetailViewData _videoDetail(int aid) {
  return VideoDetailViewData(
    bvid: _TestApp.bvid,
    aid: aid,
    title: 'Video',
    pic: '',
    pubDate: 0,
    desc: '',
    owner: const VideoOwner(mid: 1, name: 'Uploader'),
    stat: const VideoStat(),
  );
}
