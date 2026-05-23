import 'package:culcul/features/video/application/danmaku_port.dart';
import 'package:culcul/features/video/data/danmaku_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'danmaku_application_providers.g.dart';

@riverpod
DanmakuPort danmakuPort(Ref ref) {
  return ref.watch(danmakuRepositoryProvider);
}
