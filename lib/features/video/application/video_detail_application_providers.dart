import 'package:culcul/features/video/application/video_detail_port.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_detail_application_providers.g.dart';

@riverpod
VideoDetailPort videoDetailPort(Ref ref) {
  return ref.watch(videoRepositoryProvider);
}
