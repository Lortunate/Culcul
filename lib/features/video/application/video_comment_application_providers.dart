import 'package:culcul/features/video/application/video_comment_port.dart';
import 'package:culcul/features/video/data/video_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_comment_application_providers.g.dart';

@riverpod
VideoCommentPort videoCommentPort(Ref ref) {
  return ref.watch(videoRepositoryProvider);
}
