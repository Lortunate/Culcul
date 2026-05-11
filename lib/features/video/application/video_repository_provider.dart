import 'package:culcul/features/video/data/danmaku_repository_impl.dart' as danmaku_data;
import 'package:culcul/features/video/data/video_repository_impl.dart' as video_data;
import 'package:culcul/features/video/domain/repositories/danmaku_repository.dart';
import 'package:culcul/features/video/domain/repositories/video_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final videoRepositoryProvider = video_data.videoRepositoryProvider;
final danmakuRepositoryProvider = danmaku_data.danmakuRepositoryProvider;

final videoRepositoryEntryProvider = Provider<VideoRepository>((ref) {
  return ref.watch(videoRepositoryProvider);
});

final danmakuRepositoryEntryProvider = Provider<DanmakuRepository>((ref) {
  return ref.watch(danmakuRepositoryProvider);
});
